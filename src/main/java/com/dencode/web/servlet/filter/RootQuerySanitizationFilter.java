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
package com.dencode.web.servlet.filter;

import java.io.IOException;
import java.util.regex.Pattern;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = "/*")
public class RootQuerySanitizationFilter implements Filter {
	
	private static final Pattern ILLEGAL_PERCENT_QUERY = Pattern.compile("%(?=.?$|[^0-9A-Fa-f]|.[^0-9A-Fa-f])");
	
	public void init(FilterConfig config) throws ServletException {
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
		if (request instanceof HttpServletRequest && response instanceof HttpServletResponse) {
			HttpServletRequest req = (HttpServletRequest)request;
			HttpServletResponse res = (HttpServletResponse)response;
			
			String query = req.getQueryString();
			
			if (query != null) {
				if (ILLEGAL_PERCENT_QUERY.matcher(query).find()) {
					// If the query has illegal percent-encoding
					
					// Escape all percent characters
					query = query.replace("%", "%25");
					
					// Redirect with the sanitized query
					res.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
					res.setHeader("Location", req.getRequestURL() + "?" + query);
					return;
				}
			}
		}
		
		chain.doFilter(request, response);
	}
	
	public void destroy() {
	}
}
