# coding=utf-8
'''
基类,封装了基础动作
'''
import yaml
import time

class BasePage():
    def __init__(self,driver):
        self.driver = driver

    def get_elements_name(self):
        with open('config/elements.yaml','r',encoding='utf-8') as file:
            elements_dict = yaml.load(file, Loader=yaml.FullLoader)
        return elements_dict            

    def find_element(self,*location):
        print(*location)
        return self.driver.find_element(*location)

    def find_elements(self,*location):
        print(*location)
        return self.driver.find_elements(*location)

    def get_time(self):
        self.now = time.strftime('%Y-%m-%d@%H-%M-%S')
        return self.now

    def get_screen_shot(self,pic_name):
        time = self.get_time()
        image_file_name = 'screenshots/%s_%s.png'%(time,pic_name)
        r=self.driver.get_screenshot_as_file(image_file_name)
        print('screenshot',r)

