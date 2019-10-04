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



println("Reset with git reset --mixed")

#= Make a new 360x640x3 matrix; let’s call this image2.
Set image2[:,:,1] to be the G channel from the original image,
image2[:,:,2] to be the B channel from the original image, and
image2[:,:,3] to be the R channel from the original image.
Use imshow() to display the original image and image2 side by
side (hint: use subplot(1,2,1) to first make a left-hand axis and
work with that; and then subplot(1,2,2) to make a right-hand axis, and
work with that). The commands figure(figsize=[x,y]), title("your text
goes here"), and axis("off") can be used to initialize a figure specified
by x and y (width and height in inches), add a title, and turn off the axis,
respectively, for aesthetics. Commit and push both the code and image to your
repo.=#

image2 = zeros(Float32, 360, 640, 3) #Create a matrix of the same dimensions and fill them with zeros
image2[:,:,1] = green
image2[:,:,2] = blue
image2[:,:,3] = red

subplot(1,2,1)
imshow(convert(Array{Float32,3}, img))
title("Original image")
axis("off")

subplot(1,2,2)
imshow(convert(Array{Float32,3}, image2))
title("Inverse-colored image")
axis("off")

#=
A “circular” rotation of elements in a matrix moves the contents of the matrix
such that elements that “fall off” one edge “circle back” to the opposite edge.
Write a function that, for given an image, circularly moves only one channel,
the red channel (remember, this is the first one) up some number of pixels, p,
such that the top p rows now become the bottom p rows. Your function should
take two arguments -- 1) your image and 2) the number of pixels you want to
shift it by -- and return the shifted image. Display both the original image
channel and the result of circularly moving the red channel up by 180 pixels.=#

"""
circle_rotate(image, p)

Given an argument image and p number of pixels to move the image,
circularly rotate rows upwards/downwards and return new channel values, and
show the image.

Args:
image (arg): image file
p (int): number of p pixels to shift rows

Returns:
new image with new red values
"""
function circle_rotate(image, p)
    copyimage = copy(image)   #make a copy of the image to avoid messing original image
    red = copyimage[:, :, 1]  #name the red channel "red"
    for i = 1:p               #for each "increase" of pixel
        for j = 1: size(red)[1]-1   #for each row
            oldrow1 = red[1,:]      #store row 1 values in a separate vector
            red[j,:] = red[j+1, :]  #make a row = to the one before it
            red[end, :] = oldrow1   #make the last row equal to the values of the first row
        end
    end
    copyimage[:,:,1] = red          #Set the red channel equal to our new red values
    return(imshow(convert(Array{Float32,3}, copyimage)))
end

circle_rotate(img, 180)

subplot(1,2,1)
imshow(convert(Array{Float32,3}, img))
title("Original image")
axis("off")

subplot(1,2,2)
circle_rotate(img, 180)
title("New image")
axis("off")




#### CHECK PREVIOUS ANSWER USING ANOTHER METHOD
"""
circle_rotate_short(image, p)

Given an argument image and p number of pixels to move, circularly rotate rows
upwards/downwards and returns new channel values.

Args:
image (arg): image file
p (int): number of p pixels to shift rows

Returns:
newred (array): new values of red channels
"""

function circle_rotate_short(image, p)
    copyimage = copy(image)
    red = copyimage[:, :, 1]
    newred = circshift(red, -p)
    return newred
end

rotatedimage = zeros(Float32, 360, 640, 3)
rotatedimage[:,:,1] = circle_rotate_short(img, 180)
rotatedimage[:,:,2] = green
rotatedimage[:,:,3]= blue
rotatedimage

subplot(1,2,2)
imshow(convert(Array{Float32,3}, rotatedimage))
title("Shifted image")
axis("off")

subplot(1,2,1)
imshow(convert(Array{Float32,3}, img))
title("Original image")
axis("off")


#= Think about the purpose of version control (why do people do it in the
first place?). How often should you commit to your repo, and why? After a new
line of code? After a few? After you complete one subquestion? After the entire
exercise set is done? What should your commit messages look like?

I think the purpose of version control is to keep track of changes especially
in files and programs that build off of each other. This is especially useful
during the process of "finding a solution", as it allow you to revert back
to working code in a previously saved version without having to trying to
re-fix your code each time you come to a dead end. I personally think
you should commit to the repo after each subquestion, as it'll often have
functions and calls that can be used in future questions. Commit messages
can be very brief and simply describe to what point that specific version
is "correct" and working properly. =# 
