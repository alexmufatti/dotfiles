#!/usr/bin/python

import os,sys,termios,tty,subprocess,argparse

from sys import exit

def main(argv):



	path=os.getenv("HOME")+"/Documents/OpenVPN"
	os.system("clear")
	parser = argparse.ArgumentParser(description='Start vpn script files')
	parser.add_argument('-m',action="store_true")

	args = parser.parse_args()
	if (args.m):
		path=os.getenv("HOME")+"/Documents/OpenVPN/machines"

	dirList=os.listdir(path)
	dirList.sort()

	vpns=[]

	for filename in dirList:
		path2=path+"/"+filename
		if os.path.isdir(path2) == False:
			continue

		dir2List= os.listdir(path2)
		for filename2 in dir2List:
			if filename2.endswith(".ovpn"):
				vpns.append([filename,path2,filename2])

	i=0
	for vpn in vpns:
		i=i+1
		print (str(i)+")"+" "+vpn[0] + " - " + vpn[2][:-5])


	ch=""

	ch = input("Select your conection (q exit): ")

	if (ch == "q"):
		print ("Exit")
		sys.exit()


	try:
		selection=int(ch)
		print (selection)
		path=str(vpns[selection-1][1])
		os.chdir(path)
		args="--config "+ str(vpns[selection-1][2])
		subprocess.call(["sudo openvpn " + args], shell=True)
	except:
		print ("Wrong selection")

if __name__ == "__main__":
	main(sys.argv[1:])
