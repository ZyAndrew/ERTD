# ERTD: An Event-RGB-Thermal Dataset for Object Detection and Instance Segmentation
Yan Zhang, Shijie Lin, Hao Li, Jialin Zhao, Yuqian Fu, Bingde Liu, Wen Yang and Lei Yu
## Equipment and Some Examples of The Dataset
<img src="images/figure1.png" width="800" hegiht="600" align=center />

- A.Three different sensors and a minicomputer on the rig 
- B.The rig mounted on the roof of the car 
- C.Some of the images in the multi-modal dataset, the first row are RGB images, the second row are thermal images, the third raw are images reconstructed from event data 
- D.Distribution of events, the red spots denote events with polarity 1, the blue spots denote 0.

## Attribution of our dataset
<img src="images/figure2.png" width="800" hegiht="600" align=center />

- A.The time span of first row is 35ms, the secoTo help readers better use these data, we an additional tag ``id'' for each object, and the same object in images of three modalities has the same idnd row is 111 ms 
- B.The distribution of objects in the object detection dataset 
- C.The distribution of instances in the instance segmentation dataset 
- D.Labeled images in the instance segmentation dataset

## Download
We have uploaded annotated images, labels and raw event data to cloud sever, users can download data by clicking the following Mega sharing links.


data | File Size |Cloud Disk Link
------------ | -------------| -------------
Multi-modal dataset for object detection | 3.34  GB |[Mega share link](https://mega.nz/#!dF10QYCA!9GheHo856EHg6sCHZaunp0qE7Rlk4RY-2aBAmOTBTS0)
Multi-modal dataset for instance segmentation | 550.7  MB |[Mega share link](https://mega.nz/#!Mo1zSQhB!6goY8dhxHGLsK73WLLso5YvztM4QBeInag9V4DblWOs)
Raw event data at daytime | 10.91 GB |[Mega share link](https://mega.nz/#!JU1kVaBT!KM9hsN1HEgDERDLjK6o21W0PDfDaQmvEr_MBUTUMeGo)
Raw event data at nighttime | 9.43  GB |[Mega share link](https://mega.nz/#!tx0AAC4T!lrhvZbQOgNxP6gVaUNrZQVrD0WtXLNpUGQ2wlZ3SXzI)
Timestamps| 551 KB|[Mega share link](https://mega.nz/#!Z591CK6Z!Uyumhg5gaPMYFjDazbCeLEQLeUAi-RM9Y5wgGGYGN40)
Calibration results | 11 kB |[Mega share link](https://mega.nz/#!4kk2UIJS!oADCHhnQi8BFF6bouN5-QbyB2pbvph9epB3BwOO-qzk)
## About the data
1.To help readers better use these data, we an additional tag ``id'' for each object, and the same object in images of three modalities has the same id.

2.We use the label tool Labelme to annotate instance segmentation dataset, then we transfer labels we get to the format that used in COCO dataset.

3.The file ``Timestamps'' record that each event image reconstructed from which event data as well as the timestamps of rgb images and thermal images.
