# HackRunningGo-iOS
## HaRunGo. 

🏃🏃🏃✈️✈️✈️
iPhone can run without legs. 😎

## Screenshot

![](http://of7whelxn.bkt.clouddn.com/HackRun-iOS.png)

## Virtual Request Header

This is simulated request header. You can use the `RHSJUserDataDefault.m` to generate one. 

```bash
POST /api/v3/login HTTP/1.1
Host: gxapp.iydsj.com
Accept: */*
Authorization: Basic DESGARDDUAN4MDM6ZGh5OTQxMTM=
Proxy-Connection: keep-alive
osType: 1
appVersion: 1.2.0
Accept-Language: zh-Hans-CN;q=1
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
DeviceId: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
CustomDeviceId: FC139628-F5F6-423A-ADBF-C8E310FCB713_iOS_sportsWorld_campus
Content-Length: 0
User-Agent: SWCampus/1.2.0 (iPhone; iOS 9.3.4; Scale/3.00)
Connection: keep-alive
Cache-Control: no-cache
```

## Select test points and get route line in map

You can select special test points freely and generate a route line in the map. Some special running routes are designed by you.

<img src="http://of7whelxn.bkt.clouddn.com/tpos2.PNG" width="300px" /> 

## Running Route Generator


The Generator can create a simulated running route. And it can pass all selected test points, which can return a `NSArray` to record Route Pointes. Just like following:

```bash
016-10-18 08:30:23.057376 HackRunningGo[2734:1102852] (
    "NSPoint: {30.771009549104736, 103.98572581422454}",
    "NSPoint: {30.770978520131187, 103.98567191589395}",
    "NSPoint: {30.77092421940317, 103.98560005145315}",
    "NSPoint: {30.769845955680669, 103.98646242474273}",
    "NSPoint: {30.769046946633427, 103.98708225554461}",
    "NSPoint: {30.768682348045726, 103.9873697133078}"
)
2016-10-18 08:30:23.057548 HackRunningGo[2734:1102852] 313
2016-10-18 08:30:27.638614 HackRunningGo[2734:1102852] (
    "NSPoint: {30.768682348045726, 103.9873697133078}",
    "NSPoint: {30.769046946633427, 103.98708225554461}",
    "NSPoint: {30.769085733635119, 103.98715411998541}",
    "NSPoint: {30.769217609322773, 103.9873786963629}",
    "NSPoint: {30.769349484827892, 103.98721700137111}",
    "NSPoint: {30.769667536765748, 103.987028357214}",
    "NSPoint: {30.770070918184132, 103.98693852666301}",
    "NSPoint: {30.770435511458256, 103.98691157749771}",
    "NSPoint: {30.770559627999212, 103.9869205605528}",
    "NSPoint: {30.770838889625171, 103.98698344193851}",
    "NSPoint: {30.771118150432571, 103.9871271708201}",
    "NSPoint: {30.771195722733797, 103.987208018316}",
    "NSPoint: {30.771397410421397, 103.9874415777486}",
    "NSPoint: {30.771909384941591, 103.98725293359151}",
    "NSPoint: {30.772398085326092, 103.98810632382599}",
    "NSPoint: {30.772421356710449, 103.98814225604639}"
) 
2016-10-18 08:30:27.638804 HackRunningGo[2734:1102852] 512
```

## MIT License

Copyright (c) 2016 Hack Swjtu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
