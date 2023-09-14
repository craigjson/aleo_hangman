program aleo_hangman_test.aleo {

    // GAME STATUSES 
    // 0 - Game not started
    // 1 - Game in progress
    // 2 - Game over
    
    mapping games: u128 => GameState;

    record HangmanGame {
        owner: address,
        word: u128,
        game_state: GameState,
    }

    struct GameState {
        guesser: address,
        word_length: u128,
        max_attempts: u128,
        game_status: u8,
        attempts_made: u128,
        guessed_letters: u128,
        game_id: u128,
    }

    transition start_game(guesser: address, word: u128, word_length:u128, public max_attempts: u128) -> HangmanGame {
        let game_state: GameState = GameState {
            guesser: guesser,
            word_length: word_length,
            max_attempts: max_attempts,
            game_status: 1u8,
            attempts_made: 0u128,
            guessed_letters: 0u128,
            game_id: 0u128,
        };
        let game: HangmanGame = HangmanGame {
            owner: self.caller,
            word: word,
            game_state: game_state,
        };
        return game then finalize(0u128, game.game_state);
    }

    finalize start_game(public game_id: u128, public game: GameState) {
        Mapping::set(games, game_id, game);
    }

    transition make_guess(game: HangmanGame, letter: u128) -> HangmanGame {
        let word: u128 = game.word;
        let game_state: GameState = game.game_state;
        let attempts_made: u128 = game_state.attempts_made;
        let game_status: u8 = 1u8;

        let game_over: bool = is_game_over(game_state, word);

        if game_over {
            game_status = 2u8;
        } else {
            let letter_guess: u128 = guess_letter(letter, game_state.guessed_letters);
            let new_attempts_made: u128 = attempts_made + 1u128;
            let new_game_state: GameState = GameState {
                guesser: game_state.guesser,
                word_length: game_state.word_length,
                max_attempts: game_state.max_attempts,
                game_status: game_status,
                attempts_made: new_attempts_made,
                guessed_letters: letter_guess,
                game_id: game_state.game_id,
            };
            game_state = new_game_state;
        }

        return then finalize(game_state.game_id, game_status, game_state);
    }

    finalize make_guess(public game_id: u128, public game_status: u8, public game: GameState) {
        // Update the Game State
        let new_game_state: GameState = GameState {
            guesser: game.guesser,
            word_length: game.word_length,
            max_attempts: game.max_attempts,
            game_status: game_status,
            attempts_made: game.attempts_made,
            guessed_letters: game.guessed_letters,
            game_id: game.game_id,
        };
        Mapping::set(games, game_id, game);
    }

    inline is_game_over(game_state: GameState, word: u128) -> bool {
        // Check if the maximum number of attempts has been reached.
        if game_state.attempts_made >= game_state.max_attempts {
            return true;
        }

        // Initialize a mask with all bits set to 0.
        let word_mask: u128 = 0u128;
        let all_guessed: bool = true;

        // For every character in the word, update the word_mask.
        // We'll loop up to 12 since that's the maximum word length.
        for i: u128 in 0u128..12u128 {
            // If the current index is beyond the word length, we simply continue and don't execute the logic inside.
            if i < game_state.word_length {
                // Update the word_mask for the current letter in the word.
                let bit_position: u128 = get_bit_position_from_word(word, i);
                word_mask = set_bit(word_mask, bit_position);
                
                // Check if the letter has been guessed.
                if !has_been_guessed(bit_position, game_state.guessed_letters) {
                    all_guessed = false;
                }
            }
        }
        return all_guessed;
    }

    // This function fetches the bit position for the ith letter in the word
    inline get_bit_position_from_word(word: u128, i: u128) -> u128 {
    // Calculate the byte position for the i-th letter (assuming 8 bits per letter)
        let bytePosition: u128 = i * 8u128;

        // Calculate the bit position within the byte (0 to 7)
        let bitPositionWithinByte: u128 = bytePosition % 8u128;

        // Calculate the bit position within the word
        let bitPosition: u128 = 7u128 - bitPositionWithinByte;

        return bitPosition;
    }
    
    inline get_bit_position(asciiValue: u128) -> u128 {
        return asciiValue - 97u128;
    }

    // Leo does not support bitwise operations on integers greater than u32, we have to implement them ourselves.
    inline set_bit(value: u128, bitPosition: u128) -> u128 {
        // Initialize a mask for the bit position
        let bitMask: u128 = 1u128;
        
        // Initialize a result variable
        let result: u128 = 0u128;

        // Iterate through each bit
        for i:u128 in 0u128..64u128 {
            // Check if the current bit position matches the specified position
            if i == bitPosition {
                // Set the bit to 1 using arithmetic
                result += bitMask;
            } else {
                // Set the bit to its current value
                result += (value / bitMask % 2u128) * bitMask;
            }
            
            // Update the bit mask for the next iteration
            bitMask *= 2u128;
        }
        
        return result;
    }


    inline check_bit(value: u128, bitPosition: u128) -> bool {
        // Initialize a mask for the bit position
        let bitMask: u128 = 1u128;
        
        // Iterate through each bit
        for i:u128 in 0u128..64u128 {
            // Check if the current bit is at the specified position
            if i == bitPosition {
                // Use arithmetic to determine the bit's status
                return (value / bitMask) % 2u128 == 0u128;
            }
            
            // Update the bit mask for the next iteration
            bitMask *= 2u128;
        }
        
        // Return false if the specified bit position is out of range
        return false;
    }

    inline guess_letter(asciiValue: u128, currentGuesses: u128) -> u128 {
        let bitPosition: u128 = get_bit_position(asciiValue);
        return set_bit(currentGuesses, bitPosition);
    }

    inline has_been_guessed(asciiValue: u128, currentGuesses: u128) -> bool {
        let bitPosition: u128 = get_bit_position(asciiValue);
        return check_bit(currentGuesses, bitPosition);
    }
}
