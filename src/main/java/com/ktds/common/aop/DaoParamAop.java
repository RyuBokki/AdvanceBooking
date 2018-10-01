package com.ktds.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DaoParamAop {
	
	private Logger logger = LoggerFactory.getLogger(DaoParamAop.class);
	
	public Object getParam(ProceedingJoinPoint pjp) {
		
		String classAndMethod = pjp.getSignature().toShortString();
		
		logger.debug(classAndMethod);
		
		Object[] paramArray = pjp.getArgs();
		
		for ( Object param : paramArray ) {
			
			logger.debug(classAndMethod + " = " + param.toString());
		}
				
		Object result = null;
		
		try {
			logger.debug("Before");
			result = pjp.proceed();

			logger.debug(classAndMethod + " = Result : " + result.toString());
		}
		
		catch(Throwable e) {
			
			logger.debug(classAndMethod + " = Exception : " + e.getCause() + ", " + e.getMessage());
			
			throw new RuntimeException(e.getMessage(), e);	
		}
		return result;
	}
}
