/**
 * (C) Copyright IBM Corp. 2019.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/**
 Metadata of a query result.
 */
public struct QueryResultMetadata: Codable, Equatable {

    /**
     The document retrieval source that produced this search result.
     */
    public enum DocumentRetrievalSource: String {
        case search = "search"
        case curation = "curation"
    }

    /**
     The document retrieval source that produced this search result.
     */
    public var documentRetrievalSource: String?

    /**
     The collection id associated with this training data set.
     */
    public var collectionID: String

    /**
     The confidence score for the given result. Calculated based on how relevant the result is estimated to be.
     confidence can range from `0.0` to `1.0`. The higher the number, the more relevant the document. The `confidence`
     value for a result was calculated using the model specified in the `document_retrieval_strategy` field of the
     result set. This field is only returned if the **natural_language_query** parameter is specified in the query.
     */
    public var confidence: Double?

    // Map each property name to the key that shall be used for encoding/decoding.
    private enum CodingKeys: String, CodingKey {
        case documentRetrievalSource = "document_retrieval_source"
        case collectionID = "collection_id"
        case confidence = "confidence"
    }

}
