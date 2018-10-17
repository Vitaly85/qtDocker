Basic HOWTO
-----------------------------
### Step 1:
  `cd PATH_WITH_DOCKERFILE && docker build -v MY_NAME:MY_VERSION --build-arg UID=$(id -u $USER) .`

-----------------------------
### Step 2:
  `TODO`  
-----------------------------
### Step 3:
  `docker run --privileged -ti -e DISPLAY=$DISPLAY --mac-address $MAC_ADDR -v /tmp:/tmp -v $YOUR_HOST_SOURCE_PATH:$YOUR_DECKER_SOURCE_PATH MY_NAME:MY_VERSION`

-----------------------------
