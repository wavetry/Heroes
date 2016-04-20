#!/usr/bin/env python
# coding=utf-8

#API-key = qcMLTOWdrv6Lo5Foq3gKn-kAJJ7KyvCF

import os,sys
from PIL import Image,ImageFilter
# tinify.key = "qcMLTOWdrv6Lo5Foq3gKn-kAJJ7KyvCF"
# tinify.key = "cZC26NWRWx9WBV0LxfRz_4oX-Mb1lXUy"

ext_files = []
ext_after_files = []
ext_strings = []

def compress(path,ext):
	dirs_files = os.listdir(path)
	index = 1
	for file_name in dirs_files:
		full_path = os.path.join(path,file_name)
		# if os.path.isdir(full_path):
			# compress(full_path,ext)
		file_ext = file_name.split(".")[-1]
		if ext != file_ext:
			continue
		im = Image.open(full_path)
		w,h = im.size 
		im.thumbnail((w/2.133,h/2.133))
		im.save(full_path, 'jpeg')
		# file_stat = os.stat(full_path)
		# before_size = file_stat [ stat.ST_SIZE ]
		# obj = [file_name,full_path,file_stat,before_size]
		# ext_files.append(obj)
		

		# source = tinify.from_file(full_path)
		# source.to_file("%s/compressed/%d.jpg" % (path,index))
		# index = index + 1

		# file_stat = os.stat(full_path)
		# after_size = file_stat [ stat.ST_SIZE ]
		# obj = [file_name,full_path,file_stat,after_size]
		# ext_after_files.append(obj)

		# ext_strings.append(file_name)


	# with open('picInfo.txt','a+') as f :
	# 	f.write("\n".join(ext_strings))

if __name__ == '__main__': 
	path = sys.path[0]
	ext = 'jpg'
	# try:
	# 	os.remove('picInfo.txt')
	# except OSError, e:
	# 	print "no such file but now creating"
	
	compress(path,ext)
	# beforeSum = sum([item[3] for item in ext_files])
	# afterSum = sum([item[3] for item in ext_after_files])
	# print str(beforeSum) + ">>>>" +str(afterSum)
	print ("Done")




