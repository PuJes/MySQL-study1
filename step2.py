# -*- coding: UTF-8 -*-
import MySQLdb
import sys
reload(sys)
sys.setdefaultencoding("utf-8")


#连接到指定的数据库 #传入数据库，返回游标和conn
def connet_to_database(dtbs):
    conn = MySQLdb.connect(
        host='localhost',
        port=3306,
        user='root',
        passwd='01622500wrl',
        charset="utf8",
        db=dtbs,
    )

    cur = conn.cursor()
    cur.execute('SET NAMES UTF8')
    return cur,conn


#提交和关闭数据库 #传入conn
def close_connetdb(conn):
    conn.commit()
    conn.close()


#对指定路径的txt文件内容进行提取再插入到对应的表格中
#传入txt路径、游标、表格名
def import_txt(folder,cur,tbl):
    with open(folder,'r') as f:
        for aline in f.readlines():
            aline = aline.encode('utf-8')
            line = aline.split()
            if tbl == 'department':
                tql = "INSERT INTO" + ' ' + tbl + ' ' + "VALUES" + "('%s','%s',%s)" % (line[0],line[1],line[2])
            if tbl == 'exam':
                tql = "INSERT INTO" + ' ' + tbl + ' ' + "VALUES" + "(%s,'%s',%s)" % (line[0], line[1], line[2])
            if tbl == 'student':
                tql = "INSERT INTO" + ' ' + tbl + ' ' + "VALUES" + "(%s,'%s','%s',%s,'%s','%s')" % (line[0], line[1], line[2],line[3],line[4],line[5])
            print tql
            try:
                cur.execute(tql)
            except Exception:
                print 'false'


if __name__ == '__main__':

    db = raw_input('conneted database:')    #输入需要连接的数据库
    tbl = raw_input('use table:')   #输入修改的表格
    folder = raw_input("txt_path:") #输入插入的txt文件的路径


    cur1,conn1 = connet_to_database(db)
    import_txt(folder,cur1,tbl)
    close_connetdb(conn1)
    print 'complete insert'

