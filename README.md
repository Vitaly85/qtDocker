Basic HOWTO
-----------------------------
### Step 0:
  download qt online installator form https://www.qt.io/download
  Put online installer in data directory
  installer must be "\*-run" file and available to use qs script

-----------------------------
### Step 1:
  `cd PATH_WITH_DOCKERFILE && docker build -v MY_NAME:MY_VERSION .`

-----------------------------
### Step 2:
  Allow connections to x-server (a.e. `xhost +` )
  
-----------------------------
### Step 3:
  `docker run --privileged -ti -e DISPLAY=$DISPLAY --mac-address $MAC_ADDR -v /tmp:/tmp -v $YOUR_HOST_SOURCE_PATH:$YOUR_DECKER_SOURCE_PATH MY_NAME:MY_VERSION`

-----------------------------
### Step 4:
  run `/artifacts/runme.sh` - for autoinstall qt (see script.qs for specify
another qt version, 5.11.2 gcc_x86 by default)
