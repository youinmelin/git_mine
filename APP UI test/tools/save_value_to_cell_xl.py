import time
import openpyxl


class ValueToCell():

    def __init__(self, trow, tcolume, tvalue,
                 file_path, file_name, sheet_name=''):
        self.trow =trow
        self.tcolume = tcolume
        self.tvalue = tvalue
        self.file_path =file_path
        self.file_name = file_name
        self.sheet_name = sheet_name

    def save_value(self):

        file_name_str = self.file_path + self.file_name
        xbook = openpyxl.load_workbook(file_name_str)

        if self.sheet_name == '':
            xsheet = xbook.active
        else:
            xsheet = xbook[self.sheet_name]

        print(self.trow,self.tcolume,self.tvalue)
        xsheet.cell(row=self.trow,column=self.tcolume,value=self.tvalue)
        xbook.save( self.file_path + self.file_name)

if __name__ == '__main__':
    save_cell = ValueToCell(6,7,777,r'../data/','login_data.xlsx')
    save_cell.save_value()
