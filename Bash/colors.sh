################################################################################
## Author:      Devin W. Leaman (4lch4)                                       ##
## Version:     1.0.0                                                         ##
## Filename:    colors.sh                                                     ##
## Created On:  07/19/2023 @ 00:18                                            ##
################################################################################
## Description:                                                               ##
##                                                                            ##
##                                                                            ##
## A collection of variables and functions useful for coloring text output in ##
## a bash terminal &/or script.                                               ##
################################################################################
## Usage:                                                                     ##
##                                                                            ##
## source ./colors.sh                                                         ##
## log_green "Hello, world."                                                  ##
################################################################################

#region Color Variables
export COLOR_NC='\033[0m'
export COLOR_BLACK='\033[0;30m'
export COLOR_GRAY='\033[1;30m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_LIGHT_GRAY='\033[0;37m'
export COLOR_WHITE='\033[1;37m'
#endregion Color Variables

#region Color Functions
function log_black() {
  echo -e "${COLOR_BLACK}$1${COLOR_NC}"
}

function log_gray() {
  echo -e "${COLOR_GRAY}$1${COLOR_NC}"
}

function log_red() {
  echo -e "${COLOR_RED}$1${COLOR_NC}"
}

function log_light_red() {
  echo -e "${COLOR_LIGHT_RED}$1${COLOR_NC}"
}

function log_green() {
  echo -e "${COLOR_GREEN}$1${COLOR_NC}"
}

function log_light_green() {
  echo -e "${COLOR_LIGHT_GREEN}$1${COLOR_NC}"
}

function log_brown() {
  echo -e "${COLOR_BROWN}$1${COLOR_NC}"
}

function log_yellow() {
  echo -e "${COLOR_YELLOW}$1${COLOR_NC}"
}

function log_blue() {
  echo -e "${COLOR_BLUE}$1${COLOR_NC}"
}

function log_light_blue() {
  echo -e "${COLOR_LIGHT_BLUE}$1${COLOR_NC}"
}

function log_purple() {
  echo -e "${COLOR_PURPLE}$1${COLOR_NC}"
}

function log_light_purple() {
  echo -e "${COLOR_LIGHT_PURPLE}$1${COLOR_NC}"
}

function log_light_cyan() {
  echo -e "${COLOR_LIGHT_CYAN}$1${COLOR_NC}"
}

function log_light_gray() {
  echo -e "${COLOR_LIGHT_GRAY}$1${COLOR_NC}"
}

function log_white() {
  echo -e "${COLOR_WHITE}$1${COLOR_NC}"
}
#endregion Color Functions

#region Generic Log Function
function log {
  local color_name=\$1
  local msg=\$2

  echo "color_name = ${color_name}"
  echo "msg = ${msg}"

  case ${color_name} in
    "black")
      color=$'\033[0;30m'
      ;;
    "gray")
      color=$'\033[1;30m'
      ;;
    "red")
      color=$'\033[0;31m'
      ;;
    "light-red")
      color=$'\033[1;31m'
      ;;
    "green")
      color=$'\033[0;32m'
      ;;
    "light-green")
      color=$'\033[1;32m'
      ;;
    "brown")
      color=$'\033[0;33m'
      ;;
    "yellow")
      color=$'\033[1;33m'
      ;;
    "blue")
      color=$'\033[0;34m'
      ;;
    "light-blue")
      color=$'\033[1;34m'
      ;;
    "purple")
      color=$'\033[0;35m'
      ;;
    "light-purple")
      color=$'\033[1;35m'
      ;;
    "cyan")
      color=$'\033[0;36m'
      ;;
    "light-cyan")
      color=$'\033[1;36m'
      ;;
    "light-gray")
      color=$'\033[0;37m'
      ;;
    "white")
      color=$'\033[1;37m'
      ;;
    *)
      echo "Invalid color name: $color_name"
      echo "Valid color names are:"
      echo "  black"
      echo "  gray"
      echo "  red"
      echo "  light-red"
      echo "  green"
      echo "  light-green"
      echo "  brown"
      echo "  yellow"
      echo "  blue"
      echo "  light-blue"
      echo "  purple"
      echo "  light-purple"
      echo "  cyan"
      echo "  light-cyan"
      echo "  light-gray"
      echo "  white"

      return 1
  esac

  # If we get here, then color name was valid
  echo -e "${color}${msg}${COLOR_NC}"
}
#endregion Generic Log Function
