# floating_bottom_bar


This package will animate a floating action button at the center and icons at the bottomNavigationBar using [AnimatedContainer](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html) and [SlideTransition](https://api.flutter.dev/flutter/widgets/SlideTransition-class.html) respectively.


### Floating Bottom Bar
![Floating Bottom Bar](https://github.com/mi-ghanshyam/floating_bottom_bar/blob/master/assets/gif/floating_bottom_bar.gif)


## Usage

### Example
    bottomNavigationBar: AnimatedBottomNavigationBar(

                  appbarColor: Colors.white,
                  appbarGradient: const LinearGradient(
                  colors: [Colors.white, Colors.white12],
                  stops: [0.2, 0.8],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
                    bottomBarItems: [
                    BottomBarItemsModel(
                        icon: const Icon(Icons.home, size: example.Dimens.iconNormal),
                        iconSelected: const Icon(Icons.home, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                        title: example.Strings.home,
                        dotColor: example.AppColors.cherryRed,
                        onTap: () => // Do something here,
                    ),
                  ],
                  bottomBarCenterModel: BottomBarCenterModel(
                    centerBackgroundColor: example.AppColors.cherryRed,
                    centerIcon: const FloatingCenterButton(
                      child: Icon(
                        Icons.add,
                        color: AppColors.white,
                      ),
                    ),
                    centerIconChild: [
                      FloatingCenterButtonChild(
                        child: const Icon(
                          Icons.home,
                          color: AppColors.white,
                        ),
                        onTap: () {},
                      ),
                      FloatingCenterButtonChild(
                        child: const Icon(
                          Icons.home,
                          color: AppColors.white,
                        ),
                        onTap: () {},
                      ),
                      FloatingCenterButtonChild(
                        child: const Icon(
                          Icons.home,
                          color: AppColors.white,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

### Required parameters

##### bottomBarItems:
This property takes List<BottomBarItemsModel> as a parameter which are use to show the icons in the bottomNavigationBar.

##### bottomBarCenterModel:
BottomBarCenterModel class is model class for bottom menu. It takes icon, iconSelected, title, titleStyle as parameters.

### Optional parameters

##### appbarColor:
This property takes a `Color` property for the appbar.

##### appbarGradient:
This property takes `Gradient` property for the appbar.


## Guideline for contributors
Contribution towards our repository is always welcome, we request contributors to create a pull request to the develop branch only.

## Guideline to report an issue/feature request
It would be great for us if the reporter can share the below things to understand the root cause of the issue.
- Library version
- Code snippet
- Logs if applicable
- Device specification like (Manufacturer, OS version, etc)
- Screenshot/video with steps to reproduce the issue

# LICENSE!
Animated Segment is [MIT-licensed](https://github.com/Mindinventory/animated_segment/blob/master/LICENSE "MIT-licensed").

# Let us know!
We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com And do let us know if you have any questions or suggestion regarding our work.
