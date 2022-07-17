import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ResponseWrapper } from '../models/response-wrapper.interface';
import { ToastMessageService } from './toast-message.service';

@Injectable({
  providedIn: 'root',
})
export class DocumentService {
  constructor(private httpClient: HttpClient, private toastMessageService: ToastMessageService) { }

  downloadFileToBrowser(resp: Blob, contentType: string, fileName: string) {
    if (resp) {
      const blob = this.b64toBlob(resp, contentType);
      const url = window.URL.createObjectURL(blob);
      const element = document.createElement('a');
      element.setAttribute('href', url);
      element.setAttribute('download', fileName);
      element.click();
      window.URL.revokeObjectURL(url);
    }
  }

  b64toBlob(b64Data: any, contentType: string) {
    const sliceSize = 512;
    const byteCharacters = atob(b64Data);
    const byteArrays = [];

    for (let offset = 0; offset < byteCharacters.length; offset += sliceSize) {
      const slice = byteCharacters.slice(offset, offset + sliceSize);

      const byteNumbers = new Array(slice.length);
      for (let i = 0; i < slice.length; i++) {
        byteNumbers[i] = slice.charCodeAt(i);
      }

      const byteArray = new Uint8Array(byteNumbers);
      byteArrays.push(byteArray);
    }

    const blob = new Blob(byteArrays, { type: contentType });
    return blob;
  }

  downloadFileAndView(resp: any, contentType: string) {
    if (resp) {
      const blob = this.b64toBlob(resp, contentType);
      const url = window.URL.createObjectURL(blob);
      window.open(url);
    }
  }

  convertIntoBase64(file: any) {
    return new Promise((resolve, reject) => {
      if (file) {
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function () {
          resolve(reader.result);
        };
        reader.onerror = function (error) {
          reject(error);
        };
      } else {
        reject('File not present');
      }
    });
  }
  Validatedocument(file: any) {
    if (file) {
      let error = file.size <= 1000000 ? true : false; //1000000
      return error;
    } else {
      return '';
    }
  }

  downloadDocumentFromServer(path: string): void {
    const request = {
      api: 'downoad document',
      request: {
        ddtDocsPath: path,
      },
      mimeType: 'application/json',
    };
    this.httpClient.post<ResponseWrapper<HttpResponse<Blob>>>('', request).subscribe({
      next: (res) => {
        this.saveFile(res, path);
      },
      error: (err) => {
        this.toastMessageService.showErrorMsg(err?.error?.errors[0]?.message, 'Error');
      },
    });
  }

  saveFile(response: ResponseWrapper<HttpResponse<any>>, path: string): void {
    if (response.status) {
      const res: any = response.response;
      const fileName = path?.substring(path?.lastIndexOf('/') + 1) || 'FileName';
      this.downloadFileToBrowser(res, response.mimeType, fileName);
    }
  }
}
