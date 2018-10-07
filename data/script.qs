var delay = 2000
var components=["qt.qt5.5112.gcc_64"]
var installationPath="/opt/Qt"

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
        widget.TargetDirectoryLineEdit.setText(installationPath);
	// TODO process "Alredy existings" error
    	gui.clickButton(buttons.NextButton, delay);
    }
}

Controller.prototype.ComponentSelectionPageCallback = function()
{
    var widget = gui.currentPageWidget();
    if (widget != null) {
        for (var component in components) {
            widget.selectComponent(component);
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

