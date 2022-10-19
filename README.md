# floating_bottom_bar


This package will animate a floating action button at the center and icons at the bottomNavigationBar using [AnimatedContainer](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html) and [SlideTransition](https://api.flutter.dev/flutter/widgets/SlideTransition-class.html) respectively.


### Floating Bottom Bar
![Floating Bottom Bar](https://github.com/mi-ghanshyam/floating_bottom_bar/blob/master/assets/gif/floating_bottom_bar.gif)


## Usage

### Example
    bottomNavigationBar: AnimatedBottomNavigationBar(
                  bottomBarItems: [
                    BottomBarItemsModel(
                        icon: const Icon(Icons.home, size: example.Dimens.iconNormal),
                        iconSelected: const Icon(Icons.home, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                        title: example.Strings.home,
                        dotColor: example.AppColors.cherryRed,
                        onTap: () =>log('Home'),
                    ),
                    const BottomBarItemsModel(
                      icon: Icon(Icons.search, size: example.Dimens.iconNormal),
                      iconSelected: Icon(Icons.search, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                      title: example.Strings.search,
                      dotColor: example.AppColors.cherryRed,
                      onTap: () =>log('Search'),
                    ),
                    const BottomBarItemsModel(
                      icon: Icon(Icons.person, size: example.Dimens.iconNormal),
                      iconSelected: Icon(Icons.person, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                      title: example.Strings.person,
                      dotColor: example.AppColors.cherryRed,
                      onTap: () =>log('Person'),
                    ),
                    const BottomBarItemsModel(
                      icon: Icon(Icons.settings, size: example.Dimens.iconNormal),
                      iconSelected: Icon(Icons.settings, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                      title: example.Strings.settings,
                      dotColor: example.AppColors.cherryRed,
                      onTap: () =>log('Settings'),
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
