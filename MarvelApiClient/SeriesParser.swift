//
//  SeriesParser.swift
//  MarvelAPIClient
//
//  Created by Pedro Vicente Gomez on 07/01/16.
//  Copyright © 2016 GoKarumi S.L. All rights reserved.
//

import Foundation
import SwiftyJSON

class SeriesParser: Parser {
    typealias T = GetSeriesDTO

    func fromJSON(json: JSON) -> T {
        return parseGetSeriesDTO(json["data"])
    }

    func seriesDTOFromJSON(json: JSON) -> SeriesDTO {
        return parseSeriesDTO(json["data"]["results"][0])
    }

    func getComicsDTOFromJSON(json: JSON) -> GetComicsDTO {
        return GetComicsDTO(
            offset: json["offset"].intValue,
            limit: json["limit"].intValue,
            count: json["count"].intValue,
            comics: parseComicsDetail(json["results"]))
    }

    private func parseGetSeriesDTO(json: JSON) -> GetSeriesDTO {
        return GetSeriesDTO(
            offset: json["offset"].intValue,
            limit: json["limit"].intValue,
            count: json["count"].intValue,
            series: parseSeries(json["results"]))
    }

    private func parseSeries(json: JSON) -> [SeriesDTO] {
        return json.arrayValue.map { parseSeriesDTO($0) }
    }

    private func parseSeriesDTO(json: JSON) -> SeriesDTO {
        return SeriesDTO(id: json["id"].stringValue,
            title: json["title"].stringValue,
            description: json["description"].string,
            startYear: json["startYear"].intValue,
            endYear: json["endYear"].intValue,
            rating: json["rating"].stringValue,
            thumbnail: parseThumbnailDTO(json["thumbnail"]),
            comics: parseComics(json["comics"]["items"])
        )
    }

    private func parseThumbnailDTO(json: JSON) -> ThumbnailDTO {
        return ThumbnailDTO(
            path: json["path"].stringValue,
            format: json["extension"].stringValue)

    }

    private func parseComics(json: JSON) -> [ComicDTO] {
        return json.arrayValue.map { ComicDTO(name: $0["name"].stringValue) }
    }

    private func parseComicsDetail(json: JSON) -> [ComicDetailDTO] {
        return json.arrayValue.map { parseComicDetail($0) }
    }

    private func parseComicDetail(json: JSON) -> ComicDetailDTO {
        return ComicDetailDTO(title: json["title"].stringValue,
            description: json["description"].string,
            images: parseComicImages(json["images"]))
    }

    private func parseComicImages(json: JSON) -> [ThumbnailDTO] {
        return json.arrayValue.map { parseThumbnailDTO($0) }
    }

}