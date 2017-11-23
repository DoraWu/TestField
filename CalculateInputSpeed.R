
# Base on the running speed (include dwell time) provided by planners, 
# calculate input speed to pass to cube *.lin file

library(foreign)
library(stringr)

# =================== first read in line file=================
source("G:\\Script Resources\\fromRaghu\\Cube_Utils\\TransitLineFileRead.R")

lineObj  <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2040_Alt1_BAT_correctSpeed\\2040lines.lin")

dwelltime <- read.dbf("C:\\serpm7\\Input\\IN-2040B\\Transit\\TSPEED.DBF", as.is = TRUE)
linkdist <- read.dbf("G:\\Projects\\FDOT_NW27BRT_188660A\\Tasks\\RWork\\2040NB_LinkDist.dbf", as.is = TRUE)

# ====== function to get distance ====================

getFullRouteLength <- function(cubeName){
    
    rtelen <- 0
    
    allnodes <- lineObj[[cubeName]]$nodeVector
    
    for (i in 2:length(allnodes)){
        nodeA = abs(allnodes[i-1])
        nodeB = abs(allnodes[i])
        
        linkAB = paste(nodeA, nodeB, sep = " ")
        linklen = linkdist$DISTANCE[linkdist$AB == linkAB]
        rtelen = rtelen + linklen
    }
    
    return(rtelen)
}



calInputSpeed <- function(cubeName, peak = TRUE, outspeed){
    usera4 <- lineObj[[cubeName]]$lineUSERA4
    
    len <- getFullRouteLength(cubeName)
    print(len)
    
    if(peak){
        dwell <- dwelltime$PK_DWELL[dwelltime$USERA4 == usera4]
    } else {
        dwell <- dwelltime$OP_DWELL[dwelltime$USERA4 == usera4]
    }
    print(dwell)
    
    routeNode <- unique(lineObj[[cubeName]]$nodeVector)
    nStops <- sum(routeNode>0) 
    print(nStops)
    
    alltime <- len/outspeed * 60
    print(alltime)
    runningtime <- alltime - nStops*dwell
    
    inspeed <- len * 60/runningtime
    return(inspeed)
}



# =========================================================
#  Flagler Base
# =========================================================

lineObj  <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2015Base_correctSpeed\\2015Base_forSpeed.lin")

# Route 51
# AM
calInputSpeed("IN_seg1", TRUE, 11.09)  # 19.68
calInputSpeed("IN_seg3", TRUE, 12.79)  # 17.96
calInputSpeed("IN_seg4", TRUE, 10.18)  # 12.16

calInputSpeed("OUT_seg4", TRUE, 11.70) # 14.83
calInputSpeed("OUT_seg3", TRUE, 15.06) # 22.79
calInputSpeed("OUT_seg1", TRUE, 16.65) # 42.18


# OP 
calInputSpeed("IN_seg1", FALSE, 13.67)  # 29.60
calInputSpeed("IN_seg3", FALSE, 12.88)  # 18.14
calInputSpeed("IN_seg4", FALSE, 7.95)   # 9.11

calInputSpeed("OUT_seg4", FALSE, 10.10) # 12.35
calInputSpeed("OUT_seg3", FALSE, 13.76) # 19.94
calInputSpeed("OUT_seg1", FALSE, 13.25) # 25.56

# PM 
calInputSpeed("IN_seg1", TRUE, 13.91)  # 30.74
calInputSpeed("IN_seg3", TRUE, 11.87)  # 16.20
calInputSpeed("IN_seg4", TRUE, 8.75)   # 10.17

calInputSpeed("OUT_seg4", TRUE, 8.25)  # 9.69
calInputSpeed("OUT_seg3", TRUE, 11.60) # 15.70
calInputSpeed("OUT_seg1", TRUE, 11.60) # 20.06


# Route 11
lineObj  <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2015Base_correctSpeed\\TROUTE_R15_SubareaRevised.LIN")

calInputSpeed("M23L33MI_AM", TRUE, 7.90)   # 12.96
calInputSpeed("M23L33MO_AM", TRUE, 8.10)   # 13.00

calInputSpeed("M23L33MI_MD", FALSE, 8.20)  # 13.79
calInputSpeed("M23L33MO_MD", FALSE, 11.10) # 22.97

calInputSpeed("M23L33MI_PM", TRUE, 8.70)   # 15.26
calInputSpeed("M23L33MO_PM", TRUE, 9.40)   # 16.71

calInputSpeed("M23L34MI_AM", TRUE, 7.90)   # 13.29
calInputSpeed("M23L34MO_AM", TRUE, 8.10)   # 13.14

calInputSpeed("M23L34MI_MD", FALSE, 8.20)  # 14.17
calInputSpeed("M23L34MO_MD", FALSE, 11.10) # 23.41

calInputSpeed("M23L34MI_PM", TRUE, 8.70)   # 15.72
calInputSpeed("M23L34MO_PM", TRUE, 9.40)   # 16.95


# =========================================================
#  Flagler No Build
# =========================================================


# =========================================================
#  Flagler TSM
# =========================================================
lineObj <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2040_TSM_correctSpeed\\routeSegments.lin")
lineObj <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2040_TSM\\2040lines.lin")
# M28L33 AM
calInputSpeed("IN_seg1", TRUE, 12.70)  # 22.37
calInputSpeed("IN_seg3", TRUE, 14.70)  # 21.98
calInputSpeed("IN_seg4", TRUE, 11.70)  # 14.39

calInputSpeed("Out_seg4", TRUE, 13.40) # 17.67
calInputSpeed("Out_seg3", TRUE, 17.30) # 28.35
calInputSpeed("Out_seg1", TRUE, 19.10) # 55.48

# MD 
calInputSpeed("IN_seg1", FALSE, 15.70) # 33.72
calInputSpeed("IN_seg3", FALSE, 14.80) # 22.20
calInputSpeed("IN_seg4", FALSE, 9.10)  # 10.65

calInputSpeed("Out_seg4", FALSE, 11.60) # 14.67
calInputSpeed("Out_seg3", FALSE, 15.80) # 24.53
calInputSpeed("Out_seg1", FALSE, 15.20) # 31.79

# PM
calInputSpeed("IN_seg1", TRUE, 16.00)  # 35.13
calInputSpeed("IN_seg3", TRUE, 13.60)  # 19.61
calInputSpeed("IN_seg4", TRUE, 10.10)  # 12.05

calInputSpeed("Out_seg4", TRUE, 9.50)   # 11.47
calInputSpeed("Out_seg3", TRUE, 13.30)  # 18.99
calInputSpeed("Out_seg1", TRUE, 13.30)  # 24.48

# route 11

lineObj <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2040_TSM_correctSpeed\\2040lines_TSM_correctSpeed.lin")

calInputSpeed("M23L33MI_AM", TRUE, 9.10)   # AM 14.04
calInputSpeed("M23L33MO_AM", TRUE, 9.40)   # AM 14.33

calInputSpeed("M23L33MI_MD", FALSE, 9.40)  # MD 14.77
calInputSpeed("M23L33MO_MD", FALSE, 12.80) # MD 24.08

calInputSpeed("M23L33MI_PM", TRUE, 10.00)  # PM 16.31
calInputSpeed("M23L33MO_PM", TRUE, 10.70)  # PM 17.59

calInputSpeed("M23L34MI_AM", TRUE, 9.10)   # AM 17.09
calInputSpeed("M23L34MO_AM", TRUE, 9.40)   # AM 16.95

calInputSpeed("M23L34MI_MD", FALSE, 9.40)  # MD 18.18
calInputSpeed("M23L34MO_MD", FALSE, 12.80) # MD 32.53

calInputSpeed("M23L34MI_PM", TRUE, 10.00)  # PM 20.56
calInputSpeed("M23L34MO_PM", TRUE, 10.70)  # PM 21.70


# =========================================================
#  Flagler Alt 1
# =========================================================

lineObj  <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2040_Alt1_BAT_correctSpeed\\2040lines.lin")

# Flagler BRT
# Panther FIU
calInputSpeed("M28L33AMI_AM", TRUE, 9.88)    # 11.82
calInputSpeed("M28L33AMO_AM", TRUE, 10.13)   # 12.28

calInputSpeed("M28L33AMI_MD", FALSE, 10.25)  # 12.35
calInputSpeed("M28L33AMO_MD", FALSE, 13.88)  # 18.26

calInputSpeed("M28L33AMI_PM", TRUE, 10.88)   # 13.28
calInputSpeed("M28L33AMO_PM", TRUE, 11.75)   # 14.75

# Dolphin -----------------------------------------
calInputSpeed("M28L33BMI_AM", TRUE, 9.88)    # 11.77
calInputSpeed("M28L33BMO_AM", TRUE, 10.13)   # 12.20

calInputSpeed("M28L33BMI_MD", FALSE, 10.25)  # 12.30
calInputSpeed("M28L33BMO_MD", FALSE, 13.88)  # 18.07

calInputSpeed("M28L33BMI_PM", TRUE, 10.88)   # 13.22
calInputSpeed("M28L33BMO_PM", TRUE, 11.75)   # 14.62

# NW 147th Ave ------------------------------------
calInputSpeed("M28L33CMI_AM", TRUE, 9.88)    # 11.60
calInputSpeed("M28L33CMO_AM", TRUE, 10.13)   # 12.01

calInputSpeed("M28L33CMI_MD", FALSE, 10.25)  # 12.11
calInputSpeed("M28L33CMO_MD", FALSE, 13.88)  # 17.68

calInputSpeed("M28L33CMI_PM", TRUE, 10.88)   # 13.00
calInputSpeed("M28L33CMO_PM", TRUE, 11.75)   # 14.36


# route 11 - FIU ----------------------------------
calInputSpeed("M23L33MI_AM", TRUE, 9.32)     # 16.75
calInputSpeed("M23L33MO_AM", TRUE, 9.56)     # 16.81

calInputSpeed("M23L33MI_MD", FALSE, 9.68)    # 17.95
calInputSpeed("M23L33MO_MD", FALSE, 13.10)   # 32.02

calInputSpeed("M23L33MI_PM", TRUE, 10.27)    # 20.09
calInputSpeed("M23L33MO_PM", TRUE, 11.09)    # 22.19

# route 11 - MOA
calInputSpeed("M23L34MI_AM", TRUE, 9.32)     # 17.88
calInputSpeed("M23L34MO_AM", TRUE, 9.56)     # 17.48

calInputSpeed("M23L34MI_MD", FALSE, 9.68)    # 19.25
calInputSpeed("M23L34MO_MD", FALSE, 13.10)   # 34.54

calInputSpeed("M23L34MI_PM", TRUE, 10.27)    # 21.74
calInputSpeed("M23L34MO_PM", TRUE, 11.09)    # 23.37

# route 11 - NW 137th Ave 
calInputSpeed("M23L39MI_AM", TRUE, 9.32)     # 15.82
calInputSpeed("M23L39MO_AM", TRUE, 9.56)     # 15.62

calInputSpeed("M23L39MI_MD", FALSE, 9.68)    # 16.89
calInputSpeed("M23L39MO_MD", FALSE, 13.10)   # 27.96

calInputSpeed("M23L39MI_PM", TRUE, 10.27)    # 18.77
calInputSpeed("M23L39MO_PM", TRUE, 11.09)    # 20.16


# =========================================================
#  Flagler Alt 1 - 2015 Base
# =========================================================

lineObj  <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2015Base_wAlt1\\TROUTE_R15_wFlaglerBAT.LIN")
dwelltime <- read.dbf("C:\\serpm7\\Input\\IN-2015R\\Transit\\TSPEED.DBF", as.is = TRUE)
linkdist <- read.dbf("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2015Base_wAlt1\\FlaglerDist_2015BAT.dbf", as.is = TRUE)

# Flagler BRT
# Panther FIU
calInputSpeed("M28L33AMI_AM", TRUE, 9.88)    # 11.83
calInputSpeed("M28L33AMO_AM", TRUE, 10.13)   # 12.27

calInputSpeed("M28L33AMI_MD", FALSE, 10.25)  # 12.37
calInputSpeed("M28L33AMO_MD", FALSE, 13.88)  # 18.24

calInputSpeed("M28L33AMI_PM", TRUE, 10.88)   # 13.30
calInputSpeed("M28L33AMO_PM", TRUE, 11.75)   # 14.73

# Dolphin -----------------------------------------
calInputSpeed("M28L33BMI_AM", TRUE, 9.88)    # 11.80
calInputSpeed("M28L33BMO_AM", TRUE, 10.13)   # 12.22

calInputSpeed("M28L33BMI_MD", FALSE, 10.25)  # 12.33
calInputSpeed("M28L33BMO_MD", FALSE, 13.88)  # 18.13

calInputSpeed("M28L33BMI_PM", TRUE, 10.88)   # 13.25
calInputSpeed("M28L33BMO_PM", TRUE, 11.75)   # 14.66

# NW 147th Ave ------------------------------------
calInputSpeed("M28L33CMI_AM", TRUE, 9.88)    # 11.61
calInputSpeed("M28L33CMO_AM", TRUE, 10.13)   # 12.01

calInputSpeed("M28L33CMI_MD", FALSE, 10.25)  # 12.12
calInputSpeed("M28L33CMO_MD", FALSE, 13.88)  # 17.66

calInputSpeed("M28L33CMI_PM", TRUE, 10.88)   # 13.02
calInputSpeed("M28L33CMO_PM", TRUE, 11.75)   # 14.35


# route 11 - FIU ----------------------------------
calInputSpeed("M23L33MI_AM", TRUE, 9.32)     # 16.83
calInputSpeed("M23L33MO_AM", TRUE, 9.56)     # 16.75

calInputSpeed("M23L33MI_MD", FALSE, 9.68)    # 18.05
calInputSpeed("M23L33MO_MD", FALSE, 13.10)   # 31.82

calInputSpeed("M23L33MI_PM", TRUE, 10.27)    # 20.21
calInputSpeed("M23L33MO_PM", TRUE, 11.09)    # 22.09

# route 11 - MOA
calInputSpeed("M23L34MI_AM", TRUE, 9.32)     # 17.88
calInputSpeed("M23L34MO_AM", TRUE, 9.56)     # 17.48

calInputSpeed("M23L34MI_MD", FALSE, 9.68)    # 19.25
calInputSpeed("M23L34MO_MD", FALSE, 13.10)   # 34.53

calInputSpeed("M23L34MI_PM", TRUE, 10.27)    # 21.73
calInputSpeed("M23L34MO_PM", TRUE, 11.09)    # 23.37

# route 11 - NW 137th Ave 
calInputSpeed("M23L39MI_AM", TRUE, 9.32)     # 15.82
calInputSpeed("M23L39MO_AM", TRUE, 9.56)     # 15.62

calInputSpeed("M23L39MI_MD", FALSE, 9.68)    # 16.89
calInputSpeed("M23L39MO_MD", FALSE, 13.10)   # 27.96

calInputSpeed("M23L39MI_PM", TRUE, 10.27)    # 18.77
calInputSpeed("M23L39MO_PM", TRUE, 11.09)    # 20.16


# ==========================================================
#   Flagler Alt 2
# ==========================================================

lineObj  <- readTLFile("G:\\Projects\\FDOT_FlaglerBRT_188634\\Tasks\\ModelInputs\\2015Base_wAlt1\\TROUTE_R15_wFlaglerBAT.LIN")


# ==========================================================
#   NW 27th Base
# ==========================================================

lineObj <- readTLFile("Z:\\SATEC\\Active\\FDOT_NW27th_188660A\\Tasks\\Runs\\2015_Base_wSpeed\\Out-2015R\\TROUTE_R15_SubareaRevised.LIN")
route297 <- lineObj[["M23L88MI_AM"]]

stops2 <- route297$nodeVector[route297$nodeVector>0]
stops2 <- unique(stops2)
stops <- unique(stops)
length(stops)


# ==========================================================
#   NW 27th No Build
# ==========================================================

lineObj  <- readTLFile("Z:\\SATEC\\Active\\FDOT_NW27th_188660A\\Tasks\\Runs\\2040_NoBuild\\IN-2040B\\Transit\\2040lines.lin")




# ============== get route 297 speed ========================

calInputSpeed("M28L27MI_AM", TRUE, 14.98)
calInputSpeed("M28L27MI_PM", TRUE, 16.77)
calInputSpeed("M28L27MI_MD", FALSE, 18.64)

calInputSpeed("M28L27MO_AM", TRUE, 19.97)
calInputSpeed("M28L27MO_PM", TRUE, 12.75)
calInputSpeed("M28L27MO_MD", FALSE, 17.10)

# ============== get route 27 speed ========================

lineObj  <- readTLFile("G:\\Projects\\FDOT_NW27BRT_188660A\\Tasks\\ModelInputs\\2040_NoBuild\\tempLineforSpeed.lin")

# Route 27
calInputSpeed("M23L45MI_n", TRUE, 9.29)   # AM 15.57
calInputSpeed("M23L45MI_n", FALSE, 10.95) # MD 20.87
calInputSpeed("M23L45MI_n", TRUE, 10.33)  # PM 18.73

calInputSpeed("M23L45MO_n", TRUE, 11.27)  # AM 20.31
calInputSpeed("M23L45MO_n", FALSE, 10.25) # MD 17.22
calInputSpeed("M23L45MO_n", TRUE, 9.05)   # PM 14.08

# Route 27 - south of corridor
calInputSpeed("M23L45MI_s", TRUE, 10.91)  # AM 22.83
calInputSpeed("M23L45MI_s", FALSE, 11.61) # MD 26.12
calInputSpeed("M23L45MI_s", TRUE, 10.38)  # PM 20.62

calInputSpeed("M23L45MO_s", TRUE, 12.34)  # AM 32.06
calInputSpeed("M23L45MO_s", FALSE, 11.04) # MD 24.55
calInputSpeed("M23L45MO_s", TRUE, 8.70)   # PM 15.36

# Route 27A via NW 37th Ave
calInputSpeed("M23L46MI_n", TRUE, 9.29)   # AM 15.32
calInputSpeed("M23L46MI_n", FALSE, 10.95) # MD 20.44
calInputSpeed("M23L46MI_n", TRUE, 10.33)  # PM 18.38

calInputSpeed("M23L46MO_n", TRUE, 11.27)  # AM 20.30
calInputSpeed("M23L46MO_n", FALSE, 10.25) # MD 17.22
calInputSpeed("M23L46MO_n", TRUE, 9.05)   # PM 14.08

# Route 27A via NW 37th Ave - south of corridor
calInputSpeed("M23L46MI_s", TRUE, 10.91)  # AM 22.83
calInputSpeed("M23L46MI_s", FALSE, 11.61) # MD 26.12
calInputSpeed("M23L46MI_s", TRUE, 10.38)  # PM 20.62

calInputSpeed("M23L46MO_s", TRUE, 12.34)  # AM 32.06
calInputSpeed("M23L46MO_s", FALSE, 11.04) # MD 24.55
calInputSpeed("M23L46MO_s", TRUE, 8.70)   # PM 15.36


# ==========================================================
#   TSM
# ==========================================================

# ============== get route 297 speed ========================

calInputSpeed("M28L27MI_AM", TRUE, 16.92)    #21.62
calInputSpeed("M28L27MI_MD", FALSE, 21.06)   #28.86
calInputSpeed("M28L27MI_PM", TRUE, 18.95)    #25.04

calInputSpeed("M28L27MO_AM", TRUE, 22.56)    #31.77
calInputSpeed("M28L27MO_MD", FALSE, 19.32)   #25.70
calInputSpeed("M28L27MO_PM", TRUE, 14.41)    #17.68

# ============== get route 27 speed ========================

lineObj  <- readTLFile("G:\\Projects\\FDOT_NW27BRT_188660A\\Tasks\\ModelInputs\\2040_NoBuild\\tempLineforSpeed.lin")

# route 27
calInputSpeed("M23L45MI_n", TRUE, 10.51)  # AM 19.33
calInputSpeed("M23L45MI_n", FALSE, 12.43) # MD 27.00
calInputSpeed("M23L45MI_n", TRUE, 11.64)  # PM 23.53

calInputSpeed("M23L45MO_n", TRUE, 12.77)  # AM 25.77
calInputSpeed("M23L45MO_n", FALSE, 11.64) # MD 21.55
calInputSpeed("M23L45MO_n", TRUE, 10.28)  # PM 17.31

# route 27A
calInputSpeed("M23L46MI_n", TRUE, 10.51)  # AM 18.96
calInputSpeed("M23L46MI_n", FALSE, 12.43) # MD 26.28
calInputSpeed("M23L46MI_n", TRUE, 11.64)  # PM 22.99

calInputSpeed("M23L46MO_n", TRUE, 12.77)  # AM 25.75
calInputSpeed("M23L46MO_n", FALSE, 11.64) # MD 21.53
calInputSpeed("M23L46MO_n", TRUE, 10.28)  # PM 17.30


# ==========================================================
#   Alt 1
# ==========================================================

# ============== get route 297 speed ========================

lineObj <- readTLFile("G:\\Projects\\FDOT_NW27BRT_188660A\\Tasks\\ModelInputs\\2040_Alt1_BAT_extendtoMIC\\route297_newSec.lin")

calInputSpeed("M28L27MI_AM", TRUE, 16.92)    #21.62
calInputSpeed("M28L27MI_AM", FALSE, 21.06)   #28.86
calInputSpeed("M28L27MI_AM", TRUE, 18.95)    #25.04

calInputSpeed("M28L27MO_AM", TRUE, 22.56)    #31.77
calInputSpeed("M28L27MO_AM", FALSE, 19.32)   #25.70
calInputSpeed("M28L27MO_AM", TRUE, 14.41)    #17.68


# ==========================================================
#  Alt1_Extended
# ==========================================================

lineObj <- readTLFile("Z:\\SATEC\\Active\\FDOT_NW27th_188660A\\Tasks\\Runs\\2040_Alt1_BAT_extended\\2040lines_BAT_extended.lin")
calInputSpeed("M28L27MI_AM", TRUE, 16.92)
