
export interface ResponseWrapper<T> {
  id: string;
  version: string;
  responseTime: string;
  response: T;
  status: boolean;
  errors: Error;
  mimeType: string; // for download file
  loggedInFlag: boolean;
}
