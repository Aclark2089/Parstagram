# Project 6 - *Parstagram*

**Parstagram** is a photo sharing app using Parse as its backend.

Time spent: **9** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"

The following **optional** features are implemented:

- [x] Show the username and creation time for each post
- [ ] When the user is uploading a photo, show a progress indicator to show how much of the photo has been uploaded
- [ ] User can connect his or her Facebook account
- [ ] User can comment on a post and see all comments for each post

The following **additional** features are implemented:

- [x] Add sign in view for creating new users
- [x] Added addition parameter for email of user on signup
- [x] Error handling for user signup information being incorrect or missing
- [x] Error handling for the camera submission of upload if caption
- [x] Setup application in tab bar controller for easy navigation
- [x] Added images for basic user profile, and tab bar items

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Programmatically working with the tab bar, I had to ask for some help on how
   to get the items to work correctly
2. Setting the sections in cells

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

This app was very enjoyable to build but I wish there had been some tutorials
for working with the camera and photo library because that is what took me the
most time for sure. I also had to consult the Parse docs quite a bit to get all
the PFFile things for getting the image into the server.

## License

    Copyright [2016] [R. Alex Clark]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
