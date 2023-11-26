## Clone a repository

Use these steps to clone from SourceTree, our client for using the repository command-line free. Cloning allows you to work on your files locally. If you don't yet have SourceTree, [download and install first](https://www.sourcetreeapp.com/). If you prefer to clone from the command line, see [Clone a repository](https://Nurul_Islam_89@bitbucket.org/nibmeetings/linkshorteningapp1.git).

1. You’ll see the clone button under the **Source** heading. Click that button.
2. Now click **Check out in SourceTree**. You may need to create a SourceTree account or log in.
3. When you see the **Clone New** dialog in SourceTree, update the destination path and name if you’d like to and then click **Clone**.
4. Open the directory you just created to see your repository’s files.

Now that you're more familiar with your Bitbucket repository, go ahead and add a new file locally. You can [push your change back to Bitbucket with SourceTree](https://confluence.atlassian.com/x/iqyBMg), or you can [add, commit,](https://confluence.atlassian.com/x/8QhODQ) and [push from the command line](https://confluence.atlassian.com/x/NQ0zDQ).

## Answers to the following questions: 

- What parts of the test did you find challenging and why? 
The most challenging part for me was to make this app multi-platform suopprted along with minimum sdk support to iOS 13. I was facing challenges because there are some technical conflict between mac os and iOS. iOS support UiKit but not AppKit, on the otherhand Mac doesn't support UiKit rather AppKit. As to provide support for iOS 13, there were many issues in SwiftUI that needs to resolve with the help of UiKit because those things were not implemented in SwiftUI. Whick makes the Mac not runnable because Mac OS doesn't support UiKit. If we need to upgrade the iOS SDK version to make the app truely multi-platform supported!

- What feature would you like to add in the future to improve the project?
I think, it would be great feature to add if user can directly open the link/url if it is valid through this app. 

Also, technically it can be upgraded to iOS 15 as minimum SDK support because there are many new featrures in swiftui for iOS 15 that can make this app more robust & extendable. 
