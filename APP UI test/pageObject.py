# -*- coding: UTF-8 -*-
'''
一个页面是一个类,封装了对针对每个界面的基本操作
'''
from base_page import BasePage
from selenium.webdriver.common.by import By
import my_logging
from time import sleep

logger = my_logging.MyLogging().getlogger()

class FirstPage(BasePage):
    '''软件欢迎页面下，关闭升级提示，跳过软件介绍'''
    def upgrade_cancel(self,elements_name):
        for i in range(30):
            ''' wait for the first element'''
            location = (By.ID,elements_name['upgrade_cancel'])
            print (i)
            if location is not None:
                logger.debug(('取消升级按钮定位', location))
                break
            else:
                sleep(1)
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
            self.get_screen_shot('欢迎页面点击取消升级失败')
        else:
            element.click()

    def skip_page(self,elements_name):
        location = (By.ID,elements_name['welcome_page_skip'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
            self.get_screen_shot('欢迎页面点击跳过失败')
        else:
            element.click()

class LoginPage(BasePage):

    def send_username(self,elements_name,username):
        location = (By.ID,elements_name['login_page_username'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
            self.get_screen_shot('登录页面填写用户名失败')
        else:
            element.send_keys(username)

    def send_password(self,elements_name,password):
        location = (By.ID,elements_name['login_page_password'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
            self.get_screen_shot('登录页面填写密码失败')
        else:
            element.send_keys(password)

    def login_btn(self,elements_name):
        location = (By.ID,elements_name['login_page_loginbtn'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
            self.get_screen_shot('登录页面点击登录按钮失败')
        else:
            element.click()

    def understand(self,elements_name):
        location = (By.ID,elements_name['home_page_understand'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
            self.get_screen_shot('登录成功点击确认失败')
        else:
            element.click()
    
    def login_toast(self,elements_name):
        location = (By.XPATH,elements_name['page_toast_xpath'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
            self.get_screen_shot('登录页面获取toast值失败')
        else:
            #print(element.text)
            return element.text


class Myself(BasePage):

    def myself(self,elements_name):
        location = (By.ID,elements_name['home_page_bottom_myself'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
        else:
            element.click()

    def myself_setup(self,elements_name):
        location = (By.ID,elements_name['myself_page_setup'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
        else:
            element.click()

    def myself_setup_logout(self,elements_name):
        location = (By.ID,elements_name['setup_page_logout'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
        else:
            element.click()

    def myself_setup_logout_confirm(self,elements_name):
        location = (By.ID,elements_name['setup_page_logout_confirm'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
        else:
            element.click()

    def myself_setup_logout_toast(self,elements_name):
        location = (By.XPATH,elements_name['page_toast_xpath'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
        else:
            #print(element.text)
            return element.text

    def myself_setup_relogin(self,elements_name):
        location = (By.ID,elements_name['setup_page_relogin'])
        try:
            element = self.find_element(*location)
        except Exception as e:
            logger.debug(('?',e))
        else:
            element.click()

if __name__ == "__main__":

    import desired_caps
    driver = desired_caps.appium_desired()

    first_page = FirstPage(driver)
    elements_name = first_page.get_elements_name()
    first_page.upgrade_cancel(elements_name)
    first_page.skip_page(elements_name)

    login_page = LoginPage(driver)
    login_page.send_username(elements_name,'abcd')
    login_page.send_password(elements_name,'')
    login_page.login_btn(elements_name)
    login_page.understand(elements_name)

