/*!
 * dencode-web
 * Copyright 2016 Mozq
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.dencode.logic;

import java.io.File;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.JarURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.CommonDencoder;
import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

public class DencodeMapper {
	
	private static final Map<String, Map<String, List<Method>>> DC_TYPE_METHOD_MAP;
	static {
		String packageName = CommonDencoder.class.getPackageName();
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		
		List<Class<?>> classes = listAnnotatedClass(packageName, Dencoder.class, classLoader);
		
		DC_TYPE_METHOD_MAP = new HashMap<>();
		
		for (Class<?> clazz : classes) {
			Dencoder dencoder = clazz.getDeclaredAnnotation(Dencoder.class);
			for (Method classMethod : clazz.getDeclaredMethods()) {
				if (classMethod.isAnnotationPresent(DencoderFunction.class)) {
					Map<String, List<Method>> methodMap = DC_TYPE_METHOD_MAP.get(dencoder.type());
					if (methodMap == null) {
						methodMap = new HashMap<>();
						DC_TYPE_METHOD_MAP.put(dencoder.type(), methodMap);
					}
					
					List<Method> functionList = methodMap.get(dencoder.method());
					if (functionList == null) {
						functionList = new ArrayList<>();
						methodMap.put(dencoder.method(), functionList);
					}
					functionList.add(classMethod);
				}
			}
		}
	}
	

	private DencodeMapper() {
		// NOP
	}
	
	
	public static Map<String, Object> dencode(String type, String method, DencodeCondition cond) {
		Map<String, Object> ret = new HashMap<>();
		
		if (type.equals("all")) {
			// all.all
			for (String t : DC_TYPE_METHOD_MAP.keySet()) {
				Map<String, List<Method>> methodMap = DC_TYPE_METHOD_MAP.get(t);
				for (String m : methodMap.keySet()) {
					for (Method function : methodMap.get(m)) {
						if (!ret.containsKey(function.getName())) {
							ret.put(function.getName(), processDencodeFunction(function, cond));
						}
					}
				}
			}
		} else {
			if (method.endsWith(".all")) {
				// type.all
				Map<String, List<Method>> methodMap = DC_TYPE_METHOD_MAP.get(type);
				if (methodMap != null) {
					for (String m : methodMap.keySet()) {
						for (Method function : methodMap.get(m)) {
							if (!ret.containsKey(function.getName())) {
								ret.put(function.getName(), processDencodeFunction(function, cond));
							}
						}
					}
				}
			} else {
				// type.sub-method
				Map<String, List<Method>> methodMap = DC_TYPE_METHOD_MAP.get(type);
				if (methodMap != null) {
					for (Method function : methodMap.get(method)) {
						if (!ret.containsKey(function.getName())) {
							ret.put(function.getName(), processDencodeFunction(function, cond));
						}
					}
				}

				
				// type.*
				Map<String, List<Method>> commonMethodMap = DC_TYPE_METHOD_MAP.get(type);
				if (commonMethodMap != null) {
					List<Method> functionList = commonMethodMap.get("*");
					if (functionList != null) {
						for (Method function : functionList) {
							if (!ret.containsKey(function.getName())) {
								ret.put(function.getName(), processDencodeFunction(function, cond));
							}
						}
					}
				}
			}
			
			// *.*
			Map<String, List<Method>> commonMethodMap = DC_TYPE_METHOD_MAP.get("*");
			if (commonMethodMap != null) {
				List<Method> functionList = commonMethodMap.get("*");
				if (functionList != null) {
					for (Method function : functionList) {
						if (!ret.containsKey(function.getName())) {
							ret.put(function.getName(), processDencodeFunction(function, cond));
						}
					}
				}
			}
		}
		
		return ret;
	}
	
	private static Object processDencodeFunction(Method function, DencodeCondition cond) {
		try {
			return function.invoke(null, cond);
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			throw new RuntimeException(e);
		}
	}
	
	private static List<Class<?>> listAnnotatedClass(String packageName, Class<? extends Annotation> annotationClass, ClassLoader classLoader) {
		String resourceName = packageName.replace('.', '/');
		URL root = classLoader.getResource(resourceName);
		
		String protocol = root.getProtocol();
		
		List<Class<?>> classList = new ArrayList<>();
		
		if (protocol.equals("file")) {
			File[] files = new File(root.getFile()).listFiles((dir, name) -> name.endsWith(".class"));
			for (File file : files) {
				String className = StringUtilz.substringBefore(file.getName(), '.');
				try {
					Class<?> clazz = Class.forName(packageName + "." + className);
					if (clazz.isAnnotationPresent(annotationClass)) {
						classList.add(clazz);
					}
				} catch (ClassNotFoundException e) {
					continue;
				}
			}
		} else if (protocol.equals("jar")) {
			try (JarFile jarFile = ((JarURLConnection) root.openConnection()).getJarFile()) {
				Enumeration<JarEntry> jarEntries = jarFile.entries();
				while (jarEntries.hasMoreElements()) {
					JarEntry jarEntry = jarEntries.nextElement();
					String jarEntryName = jarEntry.getName();
					
					if (!jarEntryName.startsWith(resourceName)) {
						continue;
					}

					if (!jarEntryName.endsWith(".class")) {
						continue;
					}
					
					String className = StringUtilz.substringBefore(StringUtilz.substringAfter(jarEntryName, '/', true), '.');
					try {
						Class<?> clazz = Class.forName(packageName + "." + className);
						if (clazz.isAnnotationPresent(annotationClass)) {
							classList.add(clazz);
						}
					} catch (ClassNotFoundException e) {
						continue;
					}
				}
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		} else {
			// NOP
		}
		
		return classList;
	}
}
