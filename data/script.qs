var delay = 2000
var components=["qt.qt5.5112.gcc_64"]

function Controller()
{
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton);
    })
}

Controller.prototype.IntroductionPageCallback = function()
{
    gui.clickButton(buttons.NextButton, delay);
}

Controller.prototype.WelcomePageCallback = function()
{
    gui.clickButton(buttons.NextButton, delay);
}

Controller.prototype.CredentialsPageCallback = function()
{
    gui.clickButton(buttons.NextButton, delay);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
    var widget = gui.currentPageWidget();
    if (widget != null) {
        widget.TargetDirectoryLineEdit.setText(installer.value("DESTINATION", "/opt/Qt"));
	// TODO process "Alredy existings" error
    	gui.clickButton(buttons.NextButton, delay);
    }
}

Controller.prototype.ComponentSelectionPageCallback = function()
{
    var widget = gui.currentPageWidget();
    console.log("Default components:" + components)
    components=installer.value("COMPONENTS",components);
    components=components.split(',');
    console.log("Used components:" + components)
    if (widget != null) {
        for (var number in components) {
            console.log("Set install componet:" + components[number])
            widget.selectComponent(components[number]);
        }
        gui.clickButton(buttons.NextButton, delay);
    }
}

Controller.prototype.LicenseAgreementPageCallback = function()
{
    var widget = gui.currentPageWidget();
    if (widget != null) {
        widget.AcceptLicenseRadioButton.setChecked(true);
        gui.clickButton(buttons.NextButton, delay);
    }
}

Controller.prototype.LicenseCheckPageCallback = function()
{
    gui.clickButton(buttons.NextButton, delay);
}

Controller.prototype.StartMenuSelectionPageCallback = function()
{
    gui.clickButton(buttons.NextButton, delay);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
    gui.clickButton(buttons.NextButton, delay);
}

Controller.prototype.FinishedPageCallback = function()
{
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
        checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton, delay * 2);
}

