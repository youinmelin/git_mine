# -*- coding: UTF-8 -*-
''' 将xlsx文件sheet中的表格写成list并返回'''

import openpyxl

class XlsxToList():
    def __init__(self,file_path,file_name,sheet_name='sheet1'):
        self.file_path = file_path
        self.file_name = file_name
        self.sheet_name = sheet_name

    def none_to_empty(self,content):
        if content is None:
            content = ''
        return content

    def save_list(self):
        file_name_str = self.file_path + self.file_name
        xbook = openpyxl.load_workbook(self.file_path + self.file_name)
        xsheet = xbook.active
        new_rows = xsheet.rows
        new_list =[]
        for each_row in new_rows:
            row_list = []
            for each_cell in each_row:
                cell_str = self.none_to_empty(each_cell.value)
                cell_str = str(cell_str)
                row_list.append(cell_str)
            new_list.append(row_list)
        return new_list

if __name__ == '__main__':
    save_to = XlsxToList(r'../data/','login_data.xlsx')
    save_to.save_list()
