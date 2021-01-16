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
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
	
	private static final String DC_TYPE_COMMON = "*";
	private static final String DC_TYPE_ALL = "all";
	private static final String DC_METHOD_COMMON = "*";
	private static final String DC_METHOD_ALL_SUFFIX = ".all";
	
	private static final Map<String, Map<String, List<Method>>> DENCODER_MAP;
	private static final List<String> AVAILABLE_DC_TYPES;
	private static final List<String> AVAILABLE_DC_METHODS;
	private static final Map<String, List<String>> AVAILABLE_DC_TYPE_METHODS;
	static {
		String packageName = CommonDencoder.class.getPackageName();
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		
		List<Class<?>> classes = listAnnotatedClass(packageName, Dencoder.class, classLoader);
		
		Map<String, Map<String, List<Method>>> dencoderMap = new LinkedHashMap<>();
		List<String> dcTypes = new ArrayList<>();
		List<String> dcMethods = new ArrayList<>();
		Map<String, List<String>> dcTypeMethods = new HashMap<>();
		
		for (Class<?> clazz : classes) {
			Dencoder dencoder = clazz.getDeclaredAnnotation(Dencoder.class);
			String type = dencoder.type();
			String method = dencoder.method();
			
			for (Method classMethod : clazz.getDeclaredMethods()) {
				if (classMethod.isAnnotationPresent(DencoderFunction.class)) {
					Map<String, List<Method>> methodMap = dencoderMap.get(type);
					if (methodMap == null) {
						methodMap = new LinkedHashMap<>();
						dencoderMap.put(type, methodMap);
					}
					
					List<Method> functionList = methodMap.get(method);
					if (functionList == null) {
						functionList = new ArrayList<>();
						methodMap.put(method, functionList);
					}
					functionList.add(classMethod);
				}
			}
			
			if (!type.equals(DC_TYPE_COMMON) && !type.equals(DC_TYPE_ALL)) {
				dcTypes.add(type);
				
				if (!method.equals(DC_METHOD_COMMON) && !method.endsWith(DC_METHOD_ALL_SUFFIX)) {
					dcMethods.add(method);
					
					List<String> methodList = dcTypeMethods.get(type);
					if (methodList == null) {
						methodList = new ArrayList<String>();
						dcTypeMethods.put(type, methodList);
					}
					methodList.add(method);
				}
			}
		}
		
		DENCODER_MAP = Collections.unmodifiableMap(dencoderMap); // inner list is modifiable
		
		AVAILABLE_DC_TYPES = Collections.unmodifiableList(dcTypes);
		AVAILABLE_DC_METHODS = Collections.unmodifiableList(dcMethods);
		AVAILABLE_DC_TYPE_METHODS = Collections.unmodifiableMap(dcTypeMethods); // inner list is modifiable
	}
	

	private DencodeMapper() {
		// NOP
	}
	
	public static void init() {
		// NOP
	}
	
	public static List<String> getAllTypes() {
		return getAvailableTypesOf(DC_TYPE_ALL);
	}
	
	public static List<String> getAllMethods() {
		return getAllMethodsOf(DC_TYPE_ALL);
	}
	
	public static List<String> getAllMethodsOf(String type) {
		return getAvailableMethodsOf(type, type + DC_METHOD_ALL_SUFFIX);
	}
	
	public static List<String> getAvailableTypesOf(String type) {
		if (type.equals(DC_TYPE_ALL)) {
			// Type all
			return AVAILABLE_DC_TYPES; 
		} else {
			// Specific type
			if (AVAILABLE_DC_TYPES.contains(type)) {
				return List.of(type);
			} else {
				return List.of();
			}
		}
	}
	
	public static List<String> getAvailableMethodsOf(String type, String method) {
		if (type.equals(DC_TYPE_ALL)) {
			// Type all
			return AVAILABLE_DC_METHODS;
		} else if (method.endsWith(DC_METHOD_ALL_SUFFIX)) {
			// Method all
			List<String> list = AVAILABLE_DC_TYPE_METHODS.get(type);
			return (list == null) ? List.of() : list;
		} else {
			// Specific method
			if (AVAILABLE_DC_METHODS.contains(method)) {
				return List.of(method);
			} else {
				return List.of();
			}
		}
	}
	
	public static Map<String, Object> dencode(String type, String method, DencodeCondition cond) {
		Map<String, Object> ret = new LinkedHashMap<>();
		
		if (type.equals(DC_TYPE_ALL)) {
			// all.all
			for (String t : DENCODER_MAP.keySet()) {
				Map<String, List<Method>> methodMap = DENCODER_MAP.get(t);
				for (String m : methodMap.keySet()) {
					for (Method function : methodMap.get(m)) {
						if (!ret.containsKey(function.getName())) {
							ret.put(function.getName(), processDencodeFunction(function, cond));
						}
					}
				}
			}
		} else {
			if (method.endsWith(DC_METHOD_ALL_SUFFIX)) {
				// type.all
				Map<String, List<Method>> methodMap = DENCODER_MAP.get(type);
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
				Map<String, List<Method>> methodMap = DENCODER_MAP.get(type);
				if (methodMap != null) {
					for (Method function : methodMap.get(method)) {
						if (!ret.containsKey(function.getName())) {
							ret.put(function.getName(), processDencodeFunction(function, cond));
						}
					}
				}

				
				// type.*
				Map<String, List<Method>> commonMethodMap = DENCODER_MAP.get(type);
				if (commonMethodMap != null) {
					List<Method> functionList = commonMethodMap.get(DC_METHOD_COMMON);
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
			Map<String, List<Method>> commonMethodMap = DENCODER_MAP.get(DC_TYPE_COMMON);
			if (commonMethodMap != null) {
				List<Method> functionList = commonMethodMap.get(DC_METHOD_COMMON);
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
