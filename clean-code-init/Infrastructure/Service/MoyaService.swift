//
//  MoyaService.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 13/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

public class APIProvider<Target: TargetType>: MoyaProvider<Target> {
    init() {
        super.init(plugins: [NetworkLoggerPlugin(verbose:true)])
    }
}

public class MoyaService:TargetType {
    
    public var baseURL: URL {
        return URL(string: "")!
    }
    
    public var path: String {
        return ""
    }
    
    public var method: Moya.Method {
        return Moya.Method.get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return [:]
    }
    
    fileprivate var apiProvider = APIProvider<MoyaService>()
}

public extension MoyaService {
    func getDecodedResponse<T:Codable>() -> Single<T> {
        return Single.create { single in
            let request = self.apiProvider.rx.request(self)
            let dispose = request.subscribe(onSuccess: { (response) in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let object = try decoder.decode(T.self, from: response.data)
                    single(.success(object))
                } catch {
                    print(error)
                }
            }, onError: {(error) in
                single(.error(error))
            })
            return dispose
        }
    }
    
      func getDataResponse() -> Single<Data> {
          return Single.create { single in
              let request = self.apiProvider.rx.request(self)
              let dispose = request.subscribe(onSuccess: { (response) in
                  if response.statusCode == 200 {
                      single(.success(response.data))
                  } else {
                    single(.success(response.data))
                  }
              }, onError: {(error) in
                  single(.error(error))
              })
              return dispose
          }
      }
}
