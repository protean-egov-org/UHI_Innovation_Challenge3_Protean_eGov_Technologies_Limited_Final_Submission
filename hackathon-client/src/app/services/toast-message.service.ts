import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class ToastMessageService {

  constructor(
    private toastr: ToastrService,
  ) { }

  showSuccessMsg(message: string, title = 'Success', config?: any) {
    this.toastr.success(message, title, config);
  }

  showInfoMsg(message: string, title = 'Information', config?: any) {
    this.toastr.info(message, title, config);
  }

  showErrorMsg(message: string, title = 'Error', config?: any) {
    this.toastr.error(message, title, config);
  }

  showWarningMsg(message: string, title: string, config?: any) {
    this.toastr.warning(message, title, config);
  }

  clearToastr() {
    this.toastr.clear();
  }

}
