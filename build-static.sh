#!/bin/bash

# Accept an optional parameter `debug` which will determine if IS_DEBUG_BUILD is set to 1 or 0
IS_DEBUG_BUILD=0
if [ "$1" == "debug" ]; then
	echo "Building debug version"
	IS_DEBUG_BUILD=1
else
	echo "Building release version"
fi

##Different build versions
#X86_64_PC="x86_64-pc-linux-gnu"
#ARM_64_PC="aarch64-linux-gnu"
#ARM_32_ANDROID="armv7a-linux-androideabi"
#ARM_64_ANDROID="aarch64-linux-android"
#X86_64_MAC="x86_64-apple-darwin21.2.0"
#ARM_64_MAC="arm64-apple-darwin21.2.0"
#
#X86_64_PC_INDEX=0
#ARM_64_PC_INDEX=1
#ARM_32_ANDROID_INDEX=2
#ARM_64_ANDROID_INDEX=3 
#X86_64_MAC_INDEX=4
#ARM_64_MAC_INDEX=5
#
#
#
#echo "Select host"
#echo "[$X86_64_PC_INDEX] $X86_64_PC"
#echo "[$ARM_64_PC_INDEX] $ARM_64_PC"
#echo "[$ARM_32_ANDROID_INDEX] $ARM_32_ANDROID"
#echo "[$ARM_64_ANDROID_INDEX] $ARM_64_ANDROID"
#echo "[$X86_64_MAC_INDEX] $X86_64_MAC"
#echo "[$ARM_64_MAC_INDEX] $ARM_64_MAC"
#
#if [ -z "$SELECTED_ARCH" ]
#then
#	read SELECTED_ARCH
#else
#	echo "Using index ${SELECTED_ARCH}"
#fi
#
#ARCH_HOST=
#case $SELECTED_ARCH in
#
#	$X86_64_PC_INDEX)
#		ARCH_HOST=$X86_64_PC
#		;;
#
#	$ARM_64_PC_INDEX)
#		ARCH_HOST=$ARM_64_PC
#		;;
#
#	$ARM_32_ANDROID_INDEX)
#		ARCH_HOST=$ARM_32_ANDROID
#		;;
#	
#	$ARM_64_ANDROID_INDEX)
#		ARCH_HOST=$ARM_64_ANDROID
#		;;
#
#	$X86_64_MAC_INDEX)
#		ARCH_HOST=$X86_64_MAC
#		;;
#
#	$ARM_64_MAC_INDEX)
#		ARCH_HOST=$ARM_64_MAC
#		;;
#
#	*)
#		ARCH_HOST=$X86_64_PC
#		;;
#esac

# if IS_DEBUG_BUILD is false/0
if [ $IS_DEBUG_BUILD -eq 0 ]
then
	# Configure and build iperf3
	#./configure --build=$X86_64_PC --host=$ARCH_HOST --enable-static --disable-shared --without-openssl
	./configure --enable-static --disable-shared --without-openssl
else
	# Configure and build iperf3 with debug symbols
	#./configure --build=$X86_64_PC --host=$ARCH_HOST --enable-static --disable-shared --without-openssl CFLAGS="-g -O0"
	./configure --enable-static --disable-shared --without-openssl CFLAGS="-g -O0"
fi


# Clean up any previous artifacts and make new build
make clean
make

#Output the artifacts for libiperf and iperf3
ls -la src/.libs | grep libiperf.so
ls -la src | grep iperf3
