# Andy (AJ) Chen
# 10/1/19
# NEU314 Exercises 3

#= Here’s an image. Use  imread() to load it into Julia and imshow() to display
it in a figure. You’ll see that it’s a color image with 360 rows by 640 columns
of pixels. Since it is in color, each pixel doesn’t not only has a luminance
values, but a red (R), green (G), and blue (B) value as well.
Each pixel also has a fourth value (alpha) that we’re not going to use here.
Therefore, this image is actually a set of four 360x640 matrices.
Use size() to see that the image is 360x640x4, in other words, it is a set of
memory slots arranged as a rectangular prism. The first 360x640 matrix
(corresponding to indices [:,:,1]) is the R channel; then G; then B; and then
alpha (which we will ignore). The figure below might be able to help you
visualize this: =#

using JLD; using PyPlot

img = imread("el-capitan.png")
imshow(convert(Array{Float32,3}, img))

#= b) Write a function that takes as input a string representing
the filename, and then loads the image file,
displays it, and extracts the red, blue, and
green channels into separate variables, and returns those variables.
In other words, your function should take an image name as an
argument and output three separate variables, that in
the case of our example image would each be a 360x640 matrix.
Commit and push your file to the repository you just set up.
=#
"""
extract_colors(filename)

Given a string filename, loads image file, displays it, and returns the
red, green, and blue channels.

Args:
filename (str): name of image file

Returns:
red, green, blue (array): red, green, and blue channel values
"""
function extract_colors(filename)
    img = imread(filename)
    imshow(convert(Array{Float32,3}, img))
    red = img[:,:,1]
    green = img[:,:,2]
    blue = img[:,:,3]
    return (red, green, blue)
end
red, green, blue = extract_colors("el-capitan.png")
