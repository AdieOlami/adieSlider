AdieSlider is a simple slider view which lets you perform a function when sliding and after sliding.

Currently not available by direct download,

# USAGE

Drag and drop the Slider Folder into your project

var adieSlider: AdieSliderView!

adieSlider = AdieSliderView(frame: CGRect.zero)
adieSlider.tag = 200 // add a tag for the purpose of dismissing
self.view.addSubview(adieSlider)



# Perform an ACTION

adieSlider.onChange = {
    print("HEY I CHANGED")
}


// REMOVE THE SLIDER VIEW
if let viewWithTag = self.view.viewWithTag(200) {
    viewWithTag.removeFromSuperview()
}


# Feel free to creat a pull request and Contribute to the project.

# TODOS
- cocoapods integration
- carthage integration

# Noticed any bug or problem, open an issue and I would respond as soon as possible.


# M.I.T Licenced
