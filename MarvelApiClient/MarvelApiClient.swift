//
//  MarvelApiClient.swift
//  MarvelApiClient
//
//  Created by Pedro Vicente on 14/11/15.
//  Copyright © 2015 GoKarumi S.L. All rights reserved.
//

import Foundation
import BothamNetworking

public class MarvelApiClient {

    static var publicKey: String = ""
    static var privateKey: String = ""

    public static func configureCredentials(publicKey: String, privateKey: String) {
        MarvelApiClient.publicKey = publicKey
        MarvelApiClient.privateKey = privateKey
        initDefaultHeaders()
        initAuthentication()
    }

    public static var charactersApiClient = CharactersApiClient(
        apiClient: bothamAPIClient,
        parser: charactersParser)

    private static var bothamAPIClient = BothamAPIClient(
        baseEndpoint: MarvelApiClientConfig.host)

    private static func initDefaultHeaders() {
        BothamAPIClient.globalRequestInterceptors.append(DefaultHeadersRequestInterceptor())
    }

    private static func initAuthentication() {
        BothamAPIClient.globalRequestInterceptors.append(
            MarvelAPIAuthentication(timeProvider: TimeProvider()))
    }

    private static var timeProvider = TimeProvider()

    private static var charactersParser = CharactersParser()

}