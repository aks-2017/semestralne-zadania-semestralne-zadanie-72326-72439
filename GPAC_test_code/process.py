import re
import fileinput
for i in range(1, 5):
    stalled = False
    stallCounter = 0
    stallTotalTime = 0
    firstTimestamp = 0
    lastDownloadTimestamp = 0
    totalDownload = 0

    for line in fileinput.input('C:\\Users\\igorf\\Desktop\\logy\\bw6rtt40BDP1\\bbb_x264_clientID' + str(i) +'.txt', inplace = True):
        if not (re.search('\[HTTP\] ',line) or re.search('\[CACHE\] ',line) or re.search('\[socket\] ',line) or re.search('Refresh seg: do_refresh 1 - seg opened 0',line) or re.search('Received Service Query Next request from input service GPAC IsoMedia Reader',line) or re.search('Next segment is not yet available',line)):
            print(line, end=' ')
        if re.search('complete at UTC', line):
            if stalled:
                stallTotalTime += int(line.split()[-2]) - lastDownloadTimestamp
            lastDownloadTimestamp = int(line.split()[-2])
            if firstTimestamp == 0:
                firstTimestamp = lastDownloadTimestamp
        if re.search('Next segment is not yet available',line):
            if not stalled:
                stallCounter += 1
            stalled = True
        if re.search('playing new segment', line):
            stalled = False
        if re.search('download stats:', line):
            totalDownload += int(line.split()[4])
    print("CLIENT " + str(i))
    print("CLIENT RUNTIME: " + str((lastDownloadTimestamp + 6000) - firstTimestamp))
    print("STALLS ENCOUNTERED: " + str(stallCounter))
    print("STALLS DURATION: " + str(stallTotalTime))
    print("TOTAL DL: " + str(totalDownload))
    print("\n")

