//
//  CharactersAPIClient.swift
//  MarvelAPIClient
//
//  Created by Pedro Vicente on 14/11/15.
//  Copyright © 2015 GoKarumi S.L. All rights reserved.
//

import Foundation
import BothamNetworking
import Result

public class CharactersAPIClient {

    private let apiClient: BothamAPIClient
    private let parser: CharactersParser

    init(apiClient: BothamAPIClient, parser: CharactersParser) {
        self.parser = parser
        self.apiClient = apiClient
    }

    public func getAll(offset offset: Int, limit: Int,
        completion: (Result<GetCharactersDTO, BothamAPIClientError>) -> ()) {
        assert(offset >= 0 && limit >= 0)
        let params =  [MarvelAPIParams.offset : "\(offset)", MarvelAPIParams.limit : "\(limit)"]
        apiClient.GET("characters", parameters: params) { response in
            completion(
                response.mapJSON {
                    return self.parser.fromJSON($0)
                }
            )
        }
    }

    public func getById(id: String, completion: (Result<CharacterDTO, BothamAPIClientError>) -> ()) {
        apiClient.GET("characters/\(id)") { response in
            completion(
                response.mapJSON {
                    return self.parser.characterDTOFromJSON($0)
                }
            )
        }

    }

}