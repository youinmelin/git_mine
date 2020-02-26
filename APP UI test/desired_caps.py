# coding:utf-8
import yaml
from appium import webdriver
import my_logging
from time import sleep

logger = my_logging.MyLogging().getlogger()

def appium_desired():
    caps={}
    with open('config/caps.yaml','r',encoding='utf-8') as file:
        caps = yaml.load(file, Loader=yaml.FullLoader)

    logger.debug(caps)
    remote_url = 'http://localhost:4723/wd/hub'
    driver = webdriver.Remote(remote_url,caps)
    driver.implicitly_wait(5)
    return driver

if __name__ == '__main__':
    appium_desired()
