# coding:utf-8
'''
功能：将文本文件里的内容转存到一个Excel文件中
同一文件夹下每个文本文件，对应一个sheet
文本文件的文件名是sheetname
文本文件里每一行对应Excel文件的每一行
文本文件每一行的内容以空格分隔，对应的是每一列
excel 文件名默认是result.xlsx
'''
import os
import save_list_to_xlsx

class SaveTxtToXlsx():
    def __init__(self,path='result/',xlsx_name='result.xlsx'):
        self.path = path
        self.xlsx_name = xlsx_name 
# get list of all the files
    def get_filelist(self):
        files_list = os.listdir(self.path)
        return files_list
# readlines from every file , save to list
    def save_to_list(self):
        for txt_name in self.get_filelist():
            if '.txt' in txt_name:
                with open (self.path+txt_name,'r') as f:
                    txt_name = txt_name[0:-4]
                    content_list = [['date', 'time',txt_name]]
                    for content_str in f.readlines():
                        content_list.append(content_str.split())
                # use module save_list_to_xlsx ,save to xlsx
                saveX = save_list_to_xlsx.SaveListToXlsx
                saveX.write_xlsx_file(self,content_list,self.path,txt_name)


