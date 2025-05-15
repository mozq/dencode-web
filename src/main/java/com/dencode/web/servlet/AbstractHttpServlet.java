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
package com.dencode.web.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AbstractHttpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ThreadLocal<HttpReqRes> localReqRes = new ThreadLocal<HttpReqRes>();
	
	protected void doInit() throws Exception {
	}
	
	protected void doDestroy() throws Exception {
	}
	
	protected void doGet() throws Exception {
		super.doGet(request(), response());
	}
	
	protected void doPost() throws Exception {
		super.doPost(request(), response());
	}
	
	protected void doPut() throws Exception {
		super.doPut(request(), response());
	}
	
	protected void doDelete() throws Exception {
		super.doDelete(request(), response());
	}
	
	protected boolean handleError(Throwable e) throws Exception {
		response().sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		return false;
	}
	
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpReqRes reqRes = new HttpReqRes(request, response);
			this.localReqRes.set(reqRes);
			
			doInit();
			
			super.service(request, response);
			
		} catch (Throwable e) {
			try {
				handleError(e);
			} catch (RuntimeException | ServletException | IOException e1) {
				throw e1;
			} catch (Exception e1) {
				throw new RuntimeException(e1);
			}
		} finally {
			try {
				try {
					doDestroy();
				} finally {
					this.localReqRes.remove();
				}
			} catch (Throwable e) {
				try {
					handleError(e);
				} catch (RuntimeException | ServletException | IOException e1) {
					throw e1;
				} catch (Exception e1) {
					throw new RuntimeException(e1);
				}
			}
		}
	}
	
	@Override
	protected final void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			doGet();
		} catch (RuntimeException | ServletException | IOException e) {
			throw e;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	protected final void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			doPost();
		} catch (RuntimeException | ServletException | IOException e) {
			throw e;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	protected final void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			doPut();
		} catch (RuntimeException | ServletException | IOException e) {
			throw e;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	protected final void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			doDelete();
		} catch (RuntimeException | ServletException | IOException e) {
			throw e;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	protected HttpReqRes reqres() {
		return this.localReqRes.get();
	}
	
	protected HttpServletRequest request() {
		return reqres().request();
	}
	
	protected HttpServletResponse response() {
		return reqres().response();
	}
	
	protected void forward(String path) {
		reqres().forward(path);
	}
	
	protected void redirect(String path) {
		reqres().redirect(path);
	}
}
