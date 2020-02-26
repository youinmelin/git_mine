# -*- coding: UTF-8 -*-
import logging
'''
import my_logging
logger = my_logging.MyLogging().getlogger()
logger.debug('==============program started===============')
'''

class MyLogging():
    def __init__(self,log_file='debug_info.log'):
        self.logger =logging.getLogger('test')
        self.logger.setLevel(logging.DEBUG)
        formater = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(filename)s - %(lineno)d - %(message)s")

        handler = logging.FileHandler(log_file)
        handler.setLevel(logging.DEBUG)
        handler.setFormatter(formater)

        console = logging.StreamHandler()
        console.setLevel(logging.INFO)
        console.setFormatter(formater)

        self.logger.addHandler(handler)
        self.logger.addHandler(console)
        
        self.logger.removeHandler(self.logger)
    def getlogger(self):
        return self.logger
   

