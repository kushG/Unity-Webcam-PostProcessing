Applies a grayscale filter on web cam feed as a part of post processing in such a way that only web cam texture is rendered in greyscale whereas all other things that lies between camera and webcam are colored.
This solution is based around using depth values calculated in fragment shader of Post Processing shader "DepthGrayScale" shader
