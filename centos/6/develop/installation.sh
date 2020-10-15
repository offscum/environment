#!/usr/bin/env bash


####################################################################################################


#
# 刷新配置
#
source /etc/profile


####################################################################################################


#
# 高亮
#
echo -e "\033[1m\033[33m开始安装\033[0m"


####################################################################################################


#
# 系统核心
#
SYSTEM_CORES=`cat /proc/cpuinfo| grep "processor"| wc -l`

#
# 当前源码
#
CURRENT_SOURCE="none"

#
# 脚本目录
#
SHELL_DIRECTORY=$(cd `dirname $0`; pwd)

#
# 源码目录
#
SOURCE_DIRECTORY=${SHELL_DIRECTORY}/source

#
# 安装目录
#
INSTALL_DIRECTORY=/usr/local


####################################################################################################


#
# 初始化
#
function Initialize()
{
	#
	# 创建目录
	#
	if [ ! -d "${SOURCE_DIRECTORY}" ]; then

		mkdir ${SOURCE_DIRECTORY}

		chmod 755 ${SOURCE_DIRECTORY}

	fi

	#
	# 创建目录
	#
	if [ ! -d "${INSTALL_DIRECTORY}" ]; then

		mkdir ${INSTALL_DIRECTORY}

		chmod 755 ${INSTALL_DIRECTORY}

	fi
}


####################################################################################################


#
# yum安装检测
#
function InstallCheack()
{
	while [ "1" -eq "1" ]; do

		echo ""
		echo "----------------------------------------"
		echo ""
		echo "yum install -y $@"
		echo ""
		echo "----------------------------------------"
		echo ""

		yum install -y $@

		if [ $? -eq 0 ]; then

			break

		fi

	done
}


#
# yum升级检测
#
function UpgradeCheack()
{
	while [ "1" -eq "1" ]; do

		echo ""
		echo "----------------------------------------"
		echo ""
		echo "yum upgrade -y $@"
		echo ""
		echo "----------------------------------------"
		echo ""

		yum upgrade -y $@

		if [ $? -eq 0 ]; then

			break

		fi

	done
}


#
# yum安装软件
#
function YumInstall()
{
	#
	# 添加源
	#
	wget https://copr.fedorainfracloud.org/coprs/daveisfera/devtoolset2/repo/epel-6/daveisfera-devtoolset2-epel-6.repo -O /etc/yum.repos.d/devtools-2.repo
	wget https://copr.fedorainfracloud.org/coprs/wangchao/devtoolset-3/repo/epel-6/wangchao-devtoolset-3-epel-6.repo -O /etc/yum.repos.d/devtools-3.repo
	wget https://copr.fedorainfracloud.org/coprs/hhorak/devtoolset-4-rebuild-bootstrap/repo/epel-6/hhorak-devtoolset-4-rebuild-bootstrap-epel-6.repo -O /etc/yum.repos.d/devtools-4.repo
	wget https://copr.fedorainfracloud.org/coprs/mlampe/devtoolset-7/repo/epel-6/mlampe-devtoolset-7-epel-6.repo -O /etc/yum.repos.d/devtools-7.repo

	#
	# epol
	#
	InstallCheack epel-release

	#
	# 更改内容
	#
	sed -i '1,100s/#baseurl/baseurl/g' /etc/yum.repos.d/epel.repo
	sed -i '1,100s/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/epel.repo

	#
	# SCLo
	#
	InstallCheack centos-release-scl

	#
	# yum-utils 包管理工具套件
	# yum-priorities 多yum源下优先级支持
	# yum-fastestmirror 自动选择最快的yum源
	# yum-plugin-downloadonly 下载工具
	#
	InstallCheack yum-utils yum-priorities yum-fastestmirror yum-plugin-downloadonly

	#
	# java
	#
	InstallCheack java-1.8.0-openjdk

	#
	# gcc
	#
	InstallCheack gcc gcc-c++

	#
	# gdb
	#
	InstallCheack gdb gdb-*

	#
	# git
	#
	InstallCheack git git-*

	#
	# vim
	#
	InstallCheack vim vim-*

	#
	# perl
	#
	InstallCheack perl perl-devel

	#
	# pcre
	#
	InstallCheack pcre pcre-*

	#
	# zlib
	#
	InstallCheack zlib zlib-*

	#
	# llvm
	#
	InstallCheack llvm llvm-*

	#
	# clang
	#
	InstallCheack clang clang-*

	#
	# glibc
	#
	InstallCheack glibc glibc-* glibc.i686 glibc-*.i686

	#
	# mysql
	#
	InstallCheack mysql mysql-*

	#
	# httpd
	#
	InstallCheack httpd httpd-devel

	#
	# gtest
	#
	InstallCheack gtest gtest-devel

	#
	# gmock
	#
	InstallCheack gmock gmock-devel

	#
	# sqlite
	#
	InstallCheack sqlite sqlite-*

	#
	# gcc库
	#
	InstallCheack libgcc libgcc-* libgcc.i686 libgcc-*.i686

	#
	# python
	#
	InstallCheack python python-pip python-devel

	#
	# libtool
	#
	InstallCheack libtool libtool-*

	#
	# libcurl
	#
	InstallCheack libcurl libcurl-*

	#
	# libssh2
	#
	InstallCheack libssh2 libssh2-*

	#
	# libxml2
	#
	InstallCheack libxml2 libxml2-*

	#
	# libpcap
	#
	InstallCheack libpcap libpcap-*

	#
	# openssl
	#
	InstallCheack openssl openssl-*

	#
	# openssh
	#
	InstallCheack openssh openssh-*

	#
	# libevent
	#
	InstallCheack libevent libevent-*

	#
	# binutils
	#
	InstallCheack binutils binutils-devel

	#
	# c++库
	#
	InstallCheack libstdc++ libstdc++-* libstdc++.i686 libstdc++-*.i686

	#
	# gperftools
	#
	InstallCheack gperftools gperftools-*

	#
	# devtoolset-2
	#
	InstallCheack devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c+

	#
	# devtoolset-3
	#
	InstallCheack devtoolset-3-gcc devtoolset-3-binutils devtoolset-3-gcc-c++ 

	#
	# devtoolset-4
	#
	InstallCheack devtoolset-4-gcc devtoolset-4-binutils devtoolset-4-gcc-c++ 

	#
	# devtoolset-7
	#
	InstallCheack devtoolset-7 devtoolset-7-*

	#
	# devtoolset-8
	#
	InstallCheack devtoolset-8 devtoolset-8-*

	#
	# 导入公钥
	#
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

	#
	# 导入数据源
	#
	rpm -Uvh http://www.elrepo.org/elrepo-release-6-10.el6.elrepo.noarch.rpm

	#
	# 下载内核
	#
	InstallCheack kernel-lt --enablerepo=elrepo-kernel

	#
	# xz 解压缩工具
	# tar 解压缩工具
	# bzip2 解压缩工具
	#
	InstallCheack xz tar bzip2

	#
	# mtr 路由监测工具
	# htop 进程监测工具
	# dstat 系统监测工具
	# iperf 网络测试工具
	# iftop 流量监测工具
	# iptraf 流量监测工具
	# glances 系统监测工具
	# tcpdump 抓包监测工具
	# sysstat 性能监测工具
	#
	InstallCheack mtr htop dstat iperf iftop iptraf glances tcpdump sysstat

	#
	# rsyslog syslog服务
	# crontabs 定时任务服务
	#
	InstallCheack rsyslog crontabs

	#
	# make 构建工具
	# nasm 汇编工具
	# ccache 编译器缓存工具
	# pkgconfig 用于获得某一个库/模块的所有编译相关的信息
	#
	InstallCheack make nasm ccache pkgconfig

	#
	# wget 下载工具
	# tree 树形目录查看器
	# tmux 终端复用工具
	# screen 多进程会话
	# doxygen 文档产生工具
	#
	InstallCheack wget tree tmux screen doxygen

	#
	# c-ares 安装curl需要
	# texinfo 安装gdb需要
	#
	InstallCheack c-ares texinfo

	#
	# tk-devel 安装python需要
	# libffi-devel 安装python需要
	# libuuid-devel 安装python需要
	#
	InstallCheack tk-devel libffi-devel libuuid-devel
}


#
# yum升级软件
#
function YumUpdate()
{
	#
	# nss
	#
	UpgradeCheack nss nss-*

	#
	# git
	#
	UpgradeCheack git git-*

	#
	# curl
	#
	UpgradeCheack curl curl-*
}


#
# yum清理缓存
#
function YumClean()
{
	#
	# 清除yum缓存
	#
	yum clean all
}


#
# yum处理流程
#
function YumProcess()
{
	#
	# yum安装软件
	#
	YumInstall

	#
	# yum升级软件
	#
	YumUpdate

	#
	# yum清理缓存
	#
	YumClean
}


####################################################################################################


#
# 系统处理流程
#
function SystemProcess()
{
	#
	# git配置
	#
	git config --global http.postBuffer 1024288000

	#
	# 环境变量检测
	#
	if [ `grep -w /usr/local/lib /etc/ld.so.conf | wc -l` == '0' ]; then

		echo /usr/local/lib >> /etc/ld.so.conf

	fi

	#
	# 环境变量检测
	#
	if [ `grep -w /usr/local/lib64 /etc/ld.so.conf | wc -l` == '0' ]; then

		echo /usr/local/lib64 >> /etc/ld.so.conf

	fi

	#
	# 环境变量检测
	#
	if [ `grep -w /usr/lib /etc/ld.so.conf | wc -l` == '0' ]; then

		echo /usr/lib >> /etc/ld.so.conf

	fi

	#
	# 环境变量检测
	#
	if [ `grep -w /usr/lib64 /etc/ld.so.conf | wc -l` == '0' ]; then

		echo /usr/lib64 >> /etc/ld.so.conf

	fi

	#
	# 刷新环境
	#
	ldconfig 2> /dev/null
}


####################################################################################################


#
# 软件编译
#
function PackageCompile()
{
	if [ ! -f "${INSTALL_DIRECTORY}/bin/cmake" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/cmake"

		if [ ! -d "${SOURCE_DIRECTORY}/cmake" ]; then

			cd ${SOURCE_DIRECTORY}

			wget https://cmake.org/files/v3.18/cmake-3.18.0.tar.gz

			tar -xvf cmake-3.18.0.tar.gz

			rm -rf cmake-3.18.0.tar.gz

			mv ${SOURCE_DIRECTORY}/cmake-3.18.0 ${SOURCE_DIRECTORY}/cmake

		fi

		if [ -d "${SOURCE_DIRECTORY}/cmake" ]; then

			cd ${SOURCE_DIRECTORY}/cmake

			rm -rf build && mkdir build && cd build

			../configure \
			--prefix=${INSTALL_DIRECTORY} \
			--system-curl \
			--system-zlib \
			--system-bzip2 \
			--enable-ccache \
			\
			CC=/opt/rh/devtoolset-8/root/usr/bin/gcc \
			CXX=/opt/rh/devtoolset-8/root/usr/bin/g++

			make -j${SYSTEM_CORES} && make install

		fi

		if [ ! -f "${INSTALL_DIRECTORY}/bin/cmake" ]; then

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -f "${INSTALL_DIRECTORY}/bin/openssl" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/openssl"

		if [ ! -d "${SOURCE_DIRECTORY}/openssl" ]; then

			cd ${SOURCE_DIRECTORY}

			wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz

			tar -xvf openssl-1.0.2u.tar.gz

			rm -rf openssl-1.0.2u.tar.gz

			mv ${SOURCE_DIRECTORY}/openssl-1.0.2u ${SOURCE_DIRECTORY}/openssl

		fi

		if [ -d "${SOURCE_DIRECTORY}/openssl" ]; then

			cd ${SOURCE_DIRECTORY}/openssl

			./Configure \
			--prefix=${INSTALL_DIRECTORY} \
			\
			zlib \
			no-asm \
			shared \
			threads \
			linux-x86_64

			sed -i 's/LIBDIR=lib64/LIBDIR=lib/g' Makefile

			make -j${SYSTEM_CORES} && make install

		fi

		if [ ! -f "${INSTALL_DIRECTORY}/bin/openssl" ]; then

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -f "${INSTALL_DIRECTORY}/bin/python3.9" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/python"

		if [ ! -d "${SOURCE_DIRECTORY}/python" ]; then

			cd ${SOURCE_DIRECTORY}

			wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tar.xz

			tar -xvf Python-3.9.0.tar.xz

			rm -rf Python-3.9.0.tar.xz

			mv ${SOURCE_DIRECTORY}/Python-3.9.0 ${SOURCE_DIRECTORY}/python

		fi

		if [ -d "${SOURCE_DIRECTORY}/python" ]; then

			cd ${SOURCE_DIRECTORY}/python

			rm -rf build && mkdir build && cd build

			ldconfig 2> /dev/null
			
			../configure \
			--prefix=${INSTALL_DIRECTORY} \
			--enable-shared \
			--enable-profiling \
			--enable-optimizations \
			--with-pydebug \
			--with-openssl=${INSTALL_DIRECTORY} \
			--with-ssl-default-suites=openssl \
			\
			CC=/opt/rh/devtoolset-8/root/usr/bin/gcc \
			CFLAGS=-fPIC

			make -j${SYSTEM_CORES} && make install

		fi

		if [ ! -f "${INSTALL_DIRECTORY}/bin/python3.9" ]; then

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -f "${INSTALL_DIRECTORY}/bin/gcc9.3.0" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/gcc"

		if [ ! -d "${SOURCE_DIRECTORY}/gcc" ]; then

			cd ${SOURCE_DIRECTORY}

			wget http://mirrors.ustc.edu.cn/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz

			tar -xvf gcc-9.3.0.tar.gz

			rm -rf gcc-9.3.0.tar.gz

			mv ${SOURCE_DIRECTORY}/gcc-9.3.0 ${SOURCE_DIRECTORY}/gcc

		fi

		if [ -d "${SOURCE_DIRECTORY}/gcc" ]; then

			cd ${SOURCE_DIRECTORY}/gcc

			./contrib/download_prerequisites

			rm -rf build && mkdir build && cd build

			CFLAGS=-O2 \
			CXXFLAGS=-O2 \
			../configure \
			CFLAGS=-O2 \
			CXXFLAGS=-O2 \
			-v \
			--prefix=${INSTALL_DIRECTORY} \
			--program-suffix=8.3.0 \
			--host=x86_64-redhat-linux \
			--build=x86_64-redhat-linux \
			--target=x86_64-redhat-linux \
			--enable-nls \
			--enable-dssi \
			--enable-shared \
			--enable-plugin \
			--enable-libgcj \
			--enable-libmpx \
			--enable-multilib \
			--enable-gtk-cairo \
			--enable-multiarch \
			--enable-bootstrap \
			--enable-clocale=gnu \
			--enable-__cxa_atexit \
			--enable-threads=posix \
			--enable-initfini-array \
			--enable-languages=c,c++ \
			--enable-linker-build-id \
			--enable-libstdcxx-debug \
			--enable-libgcj-multifile \
			--enable-checking=release \
			--enable-gnu-unique-object \
			--enable-libstdcxx-time=yes \
			--enable-fix-cortex-a53-843419 \
			--enable-gnu-indirect-function \
			--with-ppl \
			--with-cloog \
			--with-system-zlib \
			--with-tune=generic \
			--with-arch_32=i686 \
			--with-gcc-major-version-only \
			--with-linker-hash-style=gnu \
			--with-diagnostics-color=auto \
			--with-default-libstdcxx-abi=new \
			\
			CFLAGS=-O2 \
			CXXFLAGS=-O2

			make -j${SYSTEM_CORES} && make install

		fi

		if [ ! -f "${INSTALL_DIRECTORY}/bin/gcc9.3.0" ]; then

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -f "${INSTALL_DIRECTORY}/bin/gdb8.3" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/gdb"

		if [ ! -d "${SOURCE_DIRECTORY}/gdb" ]; then

			cd ${SOURCE_DIRECTORY}

			wget http://mirrors.ustc.edu.cn/gnu/gdb/gdb-8.3.tar.gz

			tar -xvf gdb-8.3.tar.gz

			rm -rf gdb-8.3.tar.gz

			mv ${SOURCE_DIRECTORY}/gdb-8.3 ${SOURCE_DIRECTORY}/gdb

		fi

		if [ -d "${SOURCE_DIRECTORY}/gdb" ]; then

			cd ${SOURCE_DIRECTORY}/gdb

			rm -rf build && mkdir build && cd build

			../configure \
			--prefix=${INSTALL_DIRECTORY} \
			--program-suffix=8.3 \
			--enable-lto \
			--enable-libada \
			--enable-libssp \
			--enable-host-shared \
			--enable-vtable-verify \
			--with-system-zlib \
			\
			CC=gcc9.3.0 \
			CXX=g++9.3.0 \
			CFLAGS=-fPIC \
			CXXFLAGS=-fPIC

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -f "${INSTALL_DIRECTORY}/bin/gdb8.3" ]; then

			if [ `grep -w ${INSTALL_DIRECTORY}/lib64 /etc/ld.so.conf | wc -l` == '0' ]; then

				echo ${INSTALL_DIRECTORY}/lib >> /etc/ld.so.conf

			fi

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -f "${INSTALL_DIRECTORY}/lib/libfmt.a" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/fmt"

		if [ ! -d "${SOURCE_DIRECTORY}/fmt" ]; then

			cd ${SOURCE_DIRECTORY}

			wget https://github.com/fmtlib/fmt/archive/5.3.0.tar.gz

			tar -xvf 5.3.0.tar.gz

			rm -rf 5.3.0.tar.gz

			mv ${SOURCE_DIRECTORY}/fmt-5.3.0 ${SOURCE_DIRECTORY}/fmt

		fi

		if [ -d "${SOURCE_DIRECTORY}/fmt" ]; then

			cd ${SOURCE_DIRECTORY}/fmt

			rm -rf build && mkdir build && cd build

			cmake .. \
			-G "Unix Makefiles" \
			-DFMT_DOC=OFF \
			-DFMT_TEST=OFF \
			-DCMAKE_BUILD_TYPE="Release" \
			-DCMAKE_C_FLAGS=-fPIC \
			-DCMAKE_CXX_FLAGS=-fPIC \
			-DCMAKE_INSTALL_LIBDIR=lib \
			-DCMAKE_INSTALL_PREFIX=${INSTALL_DIRECTORY}

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -f "${INSTALL_DIRECTORY}/lib/libfmt.a" ]; then

			if [ `grep -w ${INSTALL_DIRECTORY}/lib64 /etc/ld.so.conf | wc -l` == '0' ]; then

				echo ${INSTALL_DIRECTORY}/lib >> /etc/ld.so.conf

			fi

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -f "${INSTALL_DIRECTORY}/lib/libpugixml.so" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/pugixml"

		if [ ! -d "${SOURCE_DIRECTORY}/pugixml" ]; then

			cd ${SOURCE_DIRECTORY}

			git clone --depth 1 https://github.com/zeux/pugixml.git

		fi

		if [ -d "${SOURCE_DIRECTORY}/pugixml" ]; then

			cd ${SOURCE_DIRECTORY}/pugixml

			rm -rf build && mkdir build && cd build

			cmake .. \
			-G "Unix Makefiles" \
			-DCMAKE_C_FLAGS=-fPIC \
			-DCMAKE_CXX_FLAGS=-fPIC \
			-DCMAKE_BUILD_TYPE="Release" \
			-DCMAKE_INSTALL_LIBDIR=lib \
			-DCMAKE_INSTALL_PREFIX=${INSTALL_DIRECTORY} \
			-DUSE_POSTFIX=ON \
			-DBUILD_SHARED_LIBS=ON

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -f "${INSTALL_DIRECTORY}/lib/libpugixml.so" ]; then

			if [ `grep -w ${INSTALL_DIRECTORY}/lib64 /etc/ld.so.conf | wc -l` == '0' ]; then

				echo ${INSTALL_DIRECTORY}/lib >> /etc/ld.so.conf

			fi

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -d "${INSTALL_DIRECTORY}/include/rapidjson" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/rapidjson"

		if [ ! -d "${SOURCE_DIRECTORY}/rapidjson" ]; then

			cd ${SOURCE_DIRECTORY}

			git clone --depth 1 https://github.com/Tencent/rapidjson.git

		fi

		if [ -d "${SOURCE_DIRECTORY}/rapidjson" ]; then

			cd ${SOURCE_DIRECTORY}/rapidjson

			rm -rf build && mkdir build && cd build

			cmake .. \
			-G "Unix Makefiles" \
			-DCMAKE_C_FLAGS=-fPIC \
			-DCMAKE_CXX_FLAGS=-fPIC \
			-DCMAKE_BUILD_TYPE="Release" \
			-DCMAKE_INSTALL_LIBDIR=lib \
			-DCMAKE_INSTALL_PREFIX=${INSTALL_DIRECTORY} \
			-DRAPIDJSON_BUILD_EXAMPLES=OFF

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -d "${INSTALL_DIRECTORY}/include/rapidjson" ]; then

			if [ `grep -w ${INSTALL_DIRECTORY}/lib64 /etc/ld.so.conf | wc -l` == '0' ]; then

				echo ${INSTALL_DIRECTORY}/lib >> /etc/ld.so.conf

			fi

		else

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -f "${INSTALL_DIRECTORY}/bin/memcached" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/memcached"

		if [ ! -d "${SOURCE_DIRECTORY}/memcached" ]; then

			cd ${SOURCE_DIRECTORY}

			wget http://memcached.org/files/memcached-1.6.3.tar.gz

			tar -xvf memcached-1.6.3.tar.gz

			rm -rf memcached-1.6.3.tar.gz

			mv ${SOURCE_DIRECTORY}/memcached-1.6.3 ${SOURCE_DIRECTORY}/memcached

		fi

		if [ -d "${SOURCE_DIRECTORY}/memcached" ]; then

			cd ${SOURCE_DIRECTORY}/memcached

			rm -rf build && mkdir build && cd build

			../configure \
			--prefix=${INSTALL_DIRECTORY} \
			--with-libevent=/usr \
			--enable-64bit \
			--enable-static \
			--enable-seccomp \
			--enable-dependency-tracking \
			\
			CFLAGS=-fPIC

			make -j${SYSTEM_CORES} && make install

		fi

		if [ ! -f "${INSTALL_DIRECTORY}/bin/memcached" ]; then

			return 1

		fi

	fi


	####################################################################################################


	if [ ! -f "${INSTALL_DIRECTORY}/lib/libmemcached.so" ]; then

		CURRENT_SOURCE="${SOURCE_DIRECTORY}/libmemcached"

		if [ ! -d "${SOURCE_DIRECTORY}/libmemcached" ]; then

			cd ${SOURCE_DIRECTORY}

			wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz

			tar -xvf libmemcached-1.0.18.tar.gz

			rm -rf libmemcached-1.0.18.tar.gz

			mv ${SOURCE_DIRECTORY}/libmemcached-1.0.18 ${SOURCE_DIRECTORY}/libmemcached

		fi

		if [ -d "${SOURCE_DIRECTORY}/libmemcached" ]; then

			cd ${SOURCE_DIRECTORY}/libmemcached

			rm -rf build && mkdir build && cd build

			../configure \
			--prefix=${INSTALL_DIRECTORY} \
			--with-memcached=${INSTALL_DIRECTORY} \
			--enable-debug \
			--enable-assert \
			--enable-dependency-tracking \
			--enable-libmemcachedprotocol \
			\
			CFLAGS=-fPIC \
			CXXFLAGS=-fPIC

			make -j${SYSTEM_CORES} && make install

		fi

		if [ -f "${INSTALL_DIRECTORY}/lib/libmemcached.so" ]; then

			if [ `grep -w ${INSTALL_DIRECTORY}/lib64 /etc/ld.so.conf | wc -l` == '0' ]; then

				echo ${INSTALL_DIRECTORY}/lib >> /etc/ld.so.conf

			fi

		else

			return 1

		fi

	fi


	####################################################################################################


	#
	# 返回成功
	#
	return 0
}


#
# 软件安装
#
function SoftwareInstall()
{
	#
	# 软件编译
	#
	PackageCompile

	#
	# 循环处理
	#
	while [[ $? -eq 1 ]]; do

		#
		# 错误信息
		#
		echo ""
		echo "********** Compile "${CURRENT_SOURCE}" Error **********"
		echo ""

		#
		# 删除源码
		#
		rm -rf ${CURRENT_SOURCE}

		#
		# 睡眠
		#
		sleep 10s

		#
		# 软件编译
		#
		PackageCompile

	done
}


#
# 软件清理
#
function SoftwareClean()
{
	#
	# 删除源码
	#
	if [ -d "${SOURCE_DIRECTORY}" ]; then

		rm -rf ${SOURCE_DIRECTORY}

	fi
}


#
# 软件处理流程
#
function SoftwareProcess()
{
	#
	# 软件安装
	#
	SoftwareInstall

	#
	# 软件清理
	#
	SoftwareClean
}


####################################################################################################


#
# 初始化
#
Initialize

#
# yum处理流程
#
YumProcess

#
# 系统处理流程
#
SystemProcess

#
# 软件处理流程
#
SoftwareProcess


####################################################################################################


#
# 高亮
#
echo -e "\033[1m\033[33m结束安装\033[0m"


####################################################################################################
