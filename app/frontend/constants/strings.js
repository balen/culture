// 
export const LOGIN_401 = "The username or password you entered is incorrect. Please check your spelling and try again.";
export const LOGIN_MISSING_PASSWORD = "You must enter a valid password.";
export const LOGIN_INVALID_FIELDS = "You must provide all of your login information.";
export const MISSING_EMAIL = "You must enter a valid email address.";
export const NOT_AN_EMAIL = "Email address needs to be in the correct format e.g. xyz@test.com";
export const LOGIN_SHORT_PASSWORD = "Your password must be at least 6 characters long.";
export const LOGIN_PASSWORDS_DO_NOT_MATCH = "Your passwords do not match.";
export const LOGIN_MISSING_NEW_PASSWORD = "You must enter a new password.";
export const LOGIN_PASSWORDS_MUST_MATCH = "Your passwords must match.";
export const LOGIN_PASSWORD_INVALID = "Your new password must meet the security criteria.";
export const LOGIN_PASSWORD_RESET_EMAIL_SEND = "If an account with the address you specified exists you will receive an email with a password reset link.";
export const LOGIN_PASSWORD_CHANGED = "You successfully changed your password.";
export const LOGIN_TOKEN_EXPIRED = (resetPasswordLink) => `The password reset link you used is no longer valid. Please request another link here: ${resetPasswordLink}`;
export const SOMETHING_WENT_WRONG = (helpEmail) => `Oops, something went wrong on our end. Please try again in a few minutes or contact us at ${helpEmail} if the problem persists.`;

export const MODEL_SAVE_ERROR = "Error trying to save model";
export const MODEL_SAVE_SUCCESS = "Model Saved";
export const MODEL_DELETE_SUCCESS = "Model deleted";
export const MODEL_DELETE_ERROR = "Error on delete of model";
