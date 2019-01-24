Basic HOWTO
-----------------------------
### Step 0:
    download qt online installator form https://www.qt.io/download
    Put online installer in data directory
    installer must be "\*-run" file and available to use qs script

-----------------------------
### Step 1:
    Set CONTEINER_MAC_ADDR='mac'
    Set QT_COMPONENTS='qt.qt5.5121.gcc_64' or what you need
    Set HOST_DIR="/home/$USER/APP_FOLDER"
    TODO make correct conteiner version (for now it is 4 =) ) 

    use `make build` - for build docker image

-----------------------------
### Step 2:
    Allow connections to x-server (a.e. `xhost +` )
  
-----------------------------
### Step 3:
    `docker run --privileged -ti -e DISPLAY=$DISPLAY --mac-address $MAC_ADDR -v /tmp:/tmp -v $YOUR_HOST_SOURCE_PATH:$YOUR_DECKER_SOURCE_PATH MY_NAME:MY_VERSION`
    or
    `make run`

-----------------------------
### Step 4:
    Enter to docker env and run /artifacts/runme.sh - this script will install
specified Qt version (/opt/Qt for default)
    
