export interface RequestWrapper<T> {
  version: string;
  id: string;
  requestTime: string;
  request: T;
}
