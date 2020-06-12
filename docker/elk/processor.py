#!/usr/bin/env python
# -*- coding: UTF-8 -*-


import os
import sys; sys.dont_write_bytecode = True
import yaml
import shutil


#
# 处理器
#
class Processor(object):
	#
	# 构造函数
	#
	def __init__(self, argc, argv):
		self.type = 'build'
		self.path = 'docker-compose.yml'
		self.argc = argc
		self.argv = argv
		self.object = {}
		self.service_name_dict = {}
		self.volumes_config_dict = {}
		self.volumes_folder_dict = {}

		os.umask(0)

		self.__parse_arg()
		self.__parse_yml()

	#
	# 解析参数
	#
	def __parse_arg(self):
		for arg in self.argv:
			if arg in ['clean', 'build']:
				self.type = arg
			elif str.startswith(arg, "--path="):
				self.path = arg[:7]

	#
	# 解析配置
	#
	def __parse_yml(self):
		with open(self.path, 'r') as f:
			self.object = yaml.safe_load(f)['services']

	#
	# 清理数据
	#
	def clean(self):
		for service_name in self.object:
			for volumes in self.object[service_name]['volumes']:
				pos = volumes.find(':')

				if pos >= 0:
					volumes = volumes[:pos]

				if os.path.exists(volumes):
					if os.path.isdir(volumes):
						shutil.rmtree(volumes, True)

						print("Clean Folder : " + os.path.abspath(volumes))

						os.makedirs(volumes)

	#
	# 生成配置
	#
	def build(self):
		for service_name in self.object:
			pos = self.object[service_name]['image'].find(':')

			if pos == -1:
				image = self.object[service_name]['image']
			else:
				image = self.object[service_name]['image'][:pos]

			if image in self.service_name_dict.keys():
				self.service_name_dict[image].append(service_name)
			else:
				self.service_name_dict[image] = [service_name]

			config_list = []
			folder_list = []

			for volumes in self.object[service_name]['volumes']:
				pos = volumes.find(':')

				if pos >= 0:
					volumes = volumes[:pos]

				if volumes.find('/conf/') >= 0:
					pos = volumes.rfind('/')

					if pos == -1:
						folder_list.append('.')
					else:
						folder_list.append(volumes[:pos])

					if not (volumes.endswith('conf') or volumes.endswith('conf/')):
						config_list.append(volumes)
				else:
					folder_list.append(volumes)

			self.volumes_config_dict[service_name] = config_list
			self.volumes_folder_dict[service_name] = folder_list

		for service in self.service_name_dict:
			self.service_name_dict[service].sort()

			for service_name in self.service_name_dict[service]:
				for folder in self.volumes_folder_dict[service_name]:
					if os.path.exists(folder):
						os.chmod(folder, 0777)
					else:
						os.makedirs(folder)

						print("Create folder : " + os.path.abspath(folder))

		self.build_kibana()
		self.build_logstash()
		self.build_elasticsearch()

	#
	# 生成配置
	#
	def build_kibana(self, service='kibana'):
		if service not in self.service_name_dict.keys():
			return

	#
	#
	#
	def build_logstash(self, service='logstash'):
		if service not in self.service_name_dict.keys():
			return

	#
	# 生成配置
	#
	def build_elasticsearch(self, service='elasticsearch'):
		if service not in self.service_name_dict.keys():
			return

		master_list = []

		master_config = ''

		for service_name in self.service_name_dict[service]:
			if service_name.find('master') >= 0:
				master_list.append(service_name)

				if master_config == '':
					for config in self.volumes_config_dict[service_name]:
						if os.path.exists(config):
							master_config = config

		for service_name in self.service_name_dict[service]:
			for config in self.volumes_config_dict[service_name]:
				if not os.path.exists(config):
					shutil.copy(master_config, config)

				node_name = "node.name: " + service_name
				seed_hosts = "discovery.seed_hosts: [\"" + "\", \"".join(self.service_name_dict[service]) + "\"]"
				recover_after_nodes = "gateway.recover_after_nodes: " + str(len(self.service_name_dict[service]) - 1)
				initial_master_nodes = "cluster.initial_master_nodes: [\"" + "\", \"".join(master_list) + "\"]"

				if service_name in master_list:
					node_data = "node.data: false"
					node_master = "node.master: true"
				else:
					node_data = "node.data: true"
					node_master = "node.master: false"

				with open(master_config, "r") as f1, open("%s.bak" % config, "w") as f2:
					for line in f1:
						if line.startswith('node.name:'):
							f2.write(node_name + '\n')
						elif line.startswith('node.data:'):
							f2.write(node_data + '\n')
						elif line.startswith('node.master:'):
							f2.write(node_master + '\n')
						elif line.startswith('discovery.seed_hosts:'):
							f2.write(seed_hosts + '\n')
						elif line.startswith('gateway.recover_after_nodes:'):
							f2.write(recover_after_nodes + '\n')
						elif line.startswith('cluster.initial_master_nodes:'):
							f2.write(initial_master_nodes + '\n')
						else:
							f2.write(line)

					os.remove(config)
					os.rename("%s.bak" % config, config)

					print ("Builds config : " + os.path.abspath(config))

	#
	# 处理
	#
	def handle(self):
		if self.type == 'build':
			self.build()
		elif self.type == 'clean':
			self.clean()


#
# 入口函数
#
if __name__ == '__main__':
	os.chdir(sys.path[0])

	Processor(len(sys.argv), sys.argv).handle()
