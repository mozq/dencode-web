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
package com.dencode.logic.dencoder.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface Dencoder {
	/** Dencode type */
	String type();
	
	/** Dencode method */
	String method();
	
	/** true if has encoder functions */
	boolean hasEncoder();
	
	/** true if has decoder functions */
	boolean hasDecoder();
	
	/** true if uses "oe" output-encoding parameter */
	boolean useOe() default false;
	
	/** true if uses "nl" new-line parameter */
	boolean useNl() default false;
	
	/** true if uses "tz" time-zone parameter */
	boolean useTz() default false;
}
