# Plicker
A few things about the App:
As of writing this, the app has just two screens.
Questions screen:
 Shows list of questions downloaded from the Plickers API,
When the question has both the text and an image, the image is placed in the background(aspect filled)  and the question
is placed on top of it with a dark gradient background for better readability (this assumes that the image is somewhat secondary to the text).
I realized from the current contents of the API that sometimes the body(text) of the question could be missing
and the question can be within the image. In such cases, the image is shown aspect-fit and the dark overlay is hidden.

Choice/Responses screen:

a)Shows answers choices for the selected question, along with the number of people who answered each of the choices 
(Eg.2/9 for a choice means 2 out of 9 people selected this choice). The correct answer choice is marked in green and the incorrect ones
 are marked in Red
b)shows list of responses to the question

TODO:: 
For convinience/clarity, I realized that the question text/image could be shown on the responses screen as well
and tapping on the image could display it full screen
The next obvious step would be provide better visualization for response stats (could be bar graph) and allow filtering/grouping 
students by those who answered correct/incorrect or by each of the choices

Dev comments, limitations:
To quickly get things running, the models were generated using a Mac app called JSON accelaratorand then a few things were added/tweaked.
(Eg. linking choices to responses). 
The fact that the index 0, 1, 2.. in choices correspond to answers A, B, C.. is an assumption which I am not 100% sure about,
but it seems to work.
The images are loaded by AFNetworking's UIImageView category that allows both async loading and caching of images.
Since the network call is a simple GET, for sake for simplicity it's directly done using NSURLSession instead of doing anything
fancy with AFNetworking
The UI doesn't show or allow recovering from network errors as of now. 
