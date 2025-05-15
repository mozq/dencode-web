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
package com.dencode.web.jsp;

import java.io.File;

import jakarta.servlet.jsp.PageContext;

public class TaglibFunctions {
	
	public static String escapeHTML(String str) {
		if (str == null || str.isEmpty()) {
			return str;
		}
		
		int len = str.length();
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = str.charAt(i);
			
			switch (ch) {
				case '<' -> sb.append("&lt;");
				case '>' -> sb.append("&gt;");
				case '&' -> sb.append("&amp;");
				case '"' -> sb.append("&quot;");
				case '\'' -> sb.append("&apos;");
				default -> sb.append(ch);
			}
		}
		
		return sb.toString();
	}
	
	public static String escapeJavaScriptString(String str) {
		if (str == null || str.isEmpty()) {
			return str;
		}
		
		int len = str.length();
		
		StringBuilder sb = new StringBuilder(len);
		char ch = '\0', pch;
		for (int i = 0; i < len; i++) {
			pch = ch;
			ch = str.charAt(i);
			
			switch (ch) {
				case '\\' -> sb.append("\\\\");
				case '\0' -> sb.append("\\0");
				case '\b' -> sb.append("\\b");
				case '\t' -> sb.append("\\t");
				case '\n' -> sb.append("\\n");
				case '\u000B' -> sb.append("\\v");
				case '\f' -> sb.append("\\f");
				case '\r' -> sb.append("\\r");
				case '"' -> sb.append("\\\"");
				case '\'' -> sb.append("\\'");
				case '/' -> { if (pch == '<') sb.append("\\/"); else sb.append(ch); } // for XSS
				default -> sb.append(ch);
			}
		}
		
		return sb.toString();
	}
	
	public static long fileLastModified(PageContext pageContext, String filePath) {
		String realPath = pageContext.getServletContext().getRealPath(filePath);
		if (realPath == null) {
			return -1;
		}
		
		return new File(realPath).lastModified();
	}
	
	public static boolean fileExists(PageContext pageContext, String filePath) {
		String realPath = pageContext.getServletContext().getRealPath(filePath);
		if (realPath == null) {
			return false;
		}
		
		return new File(realPath).exists();
	}
}
