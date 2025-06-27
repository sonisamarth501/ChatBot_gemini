import 'package:dio/dio.dart';
import 'package:flutter_bot/core/constants/api_const.dart';
import 'package:flutter_bot/core/errors/Server_Exception.dart';
import 'package:flutter_bot/domain/entities/chat.dart';

/// Abstract class defining the contract for a remote data source
/// responsible for interacting with the chat API.
abstract class RemoteDataSource {
  /// Generates a chat message using the provided list of previous chat messages.
  ///
  /// [preChat] is a list of [ChatModel] representing the conversation history.
  /// Returns a [Future] that completes with the generated chat message as a [String],
  /// or throws a [ServerException] on API call failure.
  Future<String> generateChatMessage(List<ChatModel> preChat);
}

/// Concrete implementation of [RemoteDataSource] using the Dio package.
/// This class handles making HTTP requests to the chat API.
class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio; // Dio instance for making HTTP requests

  /// Constructor for [RemoteDataSourceImpl].
  /// Requires a [Dio] instance for dependency injection.
  RemoteDataSourceImpl({required this.dio});

  /// Implements the [generateChatMessage] method to call the chat API.
  /// It constructs the request body with conversation history, generation
  /// configuration, and safety settings.
  @override
  Future<String> generateChatMessage(List<ChatModel> preChat) async {
    // Construct the request body as required by the Gemini API (or similar LLM API).
    var reqBody = {
      // "Contents" should be a list of chat parts, mapped from ChatModel.
      // It's assumed ChatModel has a toMap() method that formats
      // each chat message into the expected API format (e.g., {"role": "user", "parts": [{"text": "..."}]}).
      "contents": preChat.map((chat) => chat.toMap()).toList(),
      // Configuration for text generation parameters.
      "generationConfig": {
        "temperature":
            0.9, // Controls randomness of the output. Higher values mean more random.
        "topK": 1, // Samples from the top K most likely tokens.
        "topP":
            1, // Samples from the smallest set of tokens whose cumulative probability exceeds topP.
        "maxOutputTokens":
            2048, // Maximum number of tokens to generate in the response.
        "stopSequences":
            [], // Optional sequences where the model should stop generating.
      },
      // Safety settings to control the types of content generated.
      "safetySettings": [
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "threshold":
              "BLOCK_MEDIUM_AND_ABOVE", // Blocks content identified as harassment.
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "threshold":
              "BLOCK_MEDIUM_AND_ABOVE", // Blocks content identified as hate speech.
        },
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "threshold":
              "BLOCK_MEDIUM_AND_ABOVE", // Blocks sexually explicit content.
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "threshold": "BLOCK_MEDIUM_AND_ABOVE", // Blocks dangerous content.
        },
      ],
    };

    try {
      // Make a POST request to the API_CONST.apiUrl with the constructed body.
      final response = await dio.post(StringConst.apiUrl, data: reqBody);

      // Print the raw response data for debugging purposes.
      print(response.data);

      // Check if the request was successful (HTTP status code 200).
      if (response.statusCode == 200) {
        // Parse the response to extract the generated text message.
        // It's expected to be nested within 'candidates' -> first candidate -> 'content' -> 'parts' -> first part -> 'text'.
        return response
            .data['candidates']
            .first['content']['parts']
            .first['text'];
      } else {
        // If the status code is not 200, throw a ServerException with a descriptive message.
        throw ServerException(
          'Failed to generate message: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      // Catch Dio-specific errors (e.g., network issues, timeouts, invalid responses).
      // You can add more specific error handling based on e.type or e.response.
      throw ServerException('Dio error generating message: ${e.message}');
    } catch (e) {
      // Catch any other unexpected errors during the process.
      throw ServerException('An unknown error occurred: $e');
    }
  }
}
