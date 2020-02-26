from appium import webdriver
from base_page import BasePage
import desired_caps
from selenium.webdriver.common.by import By
import my_logging
import pageObject
from time import sleep
import chardet

logger = my_logging.MyLogging().getlogger()

class Login():
    def login_case(self,username,password):
        logger.debug('======ready to login==========')
        driver = desired_caps.appium_desired()

        first_page = pageObject.FirstPage(driver)
        elements_name = first_page.get_elements_name()
        first_page.upgrade_cancel(elements_name)
        first_page.skip_page(elements_name)

        login_page = pageObject.LoginPage(driver)
        login_page.send_username(elements_name,username)
        login_page.send_password(elements_name,password)
        login_page.login_btn(elements_name)
        sleep(2)
        login_page.get_screen_shot('登录结果')
        return login_page.login_toast(elements_name)

if __name__ == "__main__":

    username = 'abcd'
    password = ''

    test = Login()
    return_str = test.login_case(username,password)

    expect_str = '邮箱帐户密码不能为空'
    print (chardet.detect(str.encode(expect_str)))
    print (chardet.detect(str.encode(return_str)))
    print (type(expect_str))
    print (type(return_str))
    print ('expect_str length is ',len(expect_str))
    print ('return_str length is ',len(return_str))
    if  expect_str == return_str:
        print('yes')
    else:
        print('no')

