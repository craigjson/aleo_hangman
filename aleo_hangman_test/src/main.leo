program aleo_hangman_test.aleo {

    // GAME STATUSES 
    // 0 - Game not started
    // 1 - Game in progress
    // 2 - Game over
    
    mapping games: u128 => GameState;

    record HangmanGame {
        game_state: GameState,
        word: Word,
        owner: address,
    }

    struct GameState {
        guesser: address,
        max_attempts: u8,
        game_status: u8,
        attempts_made: u8,
        game_id: u128,
        player_won: bool,
        guessed_letters: GuessedLetters,
    }

    struct Word {
        length: u8,
        letter_1: u8,
        letter_2: u8,
        letter_3: u8,
        letter_4: u8,
        letter_5: u8,
        letter_6: u8,
        letter_7: u8,
        letter_8: u8,
        letter_9: u8,
        letter_10: u8,
        letter_11: u8,
        letter_12: u8,
    }

    struct GuessedLetters {
        letter_a: bool,
        letter_b: bool,
        letter_c: bool,
        letter_d: bool,
        letter_e: bool,
        letter_f: bool,
        letter_g: bool,
        letter_h: bool,
        letter_i: bool,
        letter_j: bool,
        letter_k: bool,
        letter_l: bool,
        letter_m: bool,
        letter_n: bool,
        letter_o: bool,
        letter_p: bool,
        letter_q: bool, 
        letter_r: bool,
        letter_s: bool,
        letter_t: bool,
        letter_u: bool,
        letter_v: bool,
        letter_w: bool,
        letter_x: bool,
        letter_y: bool,
        letter_z: bool,
    }

    transition start_game(public guesser: address, word: Word, public max_attempts: u8) -> HangmanGame {
        let game_state: GameState = GameState {
            guesser: guesser,
            max_attempts: max_attempts,
            game_status: 1u8,
            attempts_made: 0u8,
            game_id: 0u128,
            player_won: false,
            guessed_letters: GuessedLetters {
                letter_a: false,
                letter_b: false,
                letter_c: false,
                letter_d: false,
                letter_e: false,
                letter_f: false,
                letter_g: false,
                letter_h: false,
                letter_i: false,
                letter_j: false,
                letter_k: false,
                letter_l: false,
                letter_m: false,
                letter_n: false,
                letter_o: false,
                letter_p: false,
                letter_q: false, 
                letter_r: false,
                letter_s: false,
                letter_t: false,
                letter_u: false,
                letter_v: false,
                letter_w: false,
                letter_x: false,
                letter_y: false,
                letter_z: false,
            }
        };
        let game: HangmanGame = HangmanGame {
            owner: self.caller,
            word: word,
            game_state: game_state,
        };
        return game then finalize(0u128, game_state);
    }

    finalize start_game(public game_id: u128, public game: GameState) {
        Mapping::set(games, game_id, game);
    }

    transition make_guess(public letter: u8, game: HangmanGame) -> HangmanGame {
        let word: Word = game.word;
        let game_state: GameState = game.game_state;
        let attempts_made: u8 = game_state.attempts_made + 1u8;
        let game_status: u8 = 1u8;
        let game_id: u128 = game_state.game_id;
        let word_length: u8 = game.word.length;
        let guesser: address = game_state.guesser;
        let max_attempts: u8 = game_state.max_attempts;
        let player_won: bool = false;

        // Set the guessed letter to true
        let guessed_letters: GuessedLetters = guess_letter(game_state.guessed_letters, letter);

        // Player has run out of guesses, you lose!
        if (attempts_made > max_attempts) {
            game_status = 2u8;
        } else {
            let correct_letters: u8 = check_all_letters(word, letter);
            // If the player has guessed all the letters, you win!
            if (correct_letters == word_length) {
                game_status = 2u8;
                player_won = true;
            }
        }
        
         let new_game_state: GameState = GameState {
            guesser: game_state.guesser,
            max_attempts: game_state.max_attempts,
            game_status: game_status,
            attempts_made: game_state.attempts_made + 1u8,
            game_id: game_id,
            player_won: player_won,
            guessed_letters: guessed_letters,
        };

        let game_record: HangmanGame = HangmanGame {
            owner: self.caller,
            word: word,
            game_state: new_game_state,
        };

        // Update the game state
        return game_record then finalize(game_id, game_state);
    }
 
    finalize make_guess(public game_id: u128, public game_state: GameState) {
        Mapping::set(games, game_id, game_state);
    }

    inline is_game_over(game_state: HangmanGame, word: Word) -> bool {
        
        return true;
    }

    // Check All Letters and Set the Guessed Letter to True
    inline guess_letter(letterStruct: GuessedLetters, letter: u8) -> GuessedLetters {
        let a_guessed: bool = false;
        if (letter == 97u8) {
            a_guessed = true;
        }
        let b_guessed: bool = false;
        if (letter == 98u8) {
            b_guessed = true;
        }
        let c_guessed: bool = false;
        if (letter == 99u8) {
            c_guessed = true;
        }
        let d_guessed: bool = false;
        if (letter == 100u8) {
            d_guessed = true;
        }
        let e_guessed: bool = false;
        if (letter == 101u8) {
            e_guessed = true;
        }
        let f_guessed: bool = false;
        if (letter == 102u8) {
            f_guessed = true;
        }
        let g_guessed: bool = false;
        if (letter == 103u8) {
            g_guessed = true;
        }
        let h_guessed: bool = false;
        if (letter == 104u8) {
            h_guessed = true;
        }
        let i_guessed: bool = false;
        if (letter == 105u8) {
            i_guessed = true;
        }
        let j_guessed: bool = false;
        if (letter == 106u8) {
            j_guessed = true;
        }
        let k_guessed: bool = false;
        if (letter == 107u8) {
            k_guessed = true;
        }
        let l_guessed: bool = false;
        if (letter == 108u8) {
            l_guessed = true;
        }
        let m_guessed: bool = false;
        if (letter == 109u8) {
            m_guessed = true;
        }
        let n_guessed: bool = false;
        if (letter == 110u8) {
            n_guessed = true;
        }
        let o_guessed: bool = false;
        if (letter == 111u8) {
            o_guessed = true;
        }
        let p_guessed: bool = false;
        if (letter == 112u8) {
            p_guessed = true;
        }
        let q_guessed: bool = false;
        if (letter == 113u8) {
            q_guessed = true;
        }
        let r_guessed: bool = false;
        if (letter == 114u8) {
            r_guessed = true;
        }
        let s_guessed: bool = false;
        if (letter == 115u8) {
            s_guessed = true;
        }
        let t_guessed: bool = false;
        if (letter == 116u8) {
            t_guessed = true;
        }
        let u_guessed: bool = false;
        if (letter == 117u8) {
            u_guessed = true;
        }
        let v_guessed: bool = false;
        if (letter == 118u8) {
            v_guessed = true;
        }
        let w_guessed: bool = false;
        if (letter == 119u8) {
            w_guessed = true;
        }
        let x_guessed: bool = false;
        if (letter == 120u8) {
            x_guessed = true;
        }
        let y_guessed: bool = false;
        if (letter == 121u8) {
            y_guessed = true;
        }
        let z_guessed: bool = false;
        if (letter == 122u8) {
            z_guessed = true;
        }
        let new_guesses: GuessedLetters = GuessedLetters {
            letter_a: a_guessed,
            letter_b: b_guessed,
            letter_c: c_guessed,
            letter_d: d_guessed,
            letter_e: e_guessed,
            letter_f: f_guessed,
            letter_g: g_guessed,
            letter_h: h_guessed,
            letter_i: i_guessed,
            letter_j: j_guessed,
            letter_k: k_guessed,
            letter_l: l_guessed,
            letter_m: m_guessed,
            letter_n: n_guessed,
            letter_o: o_guessed,
            letter_p: p_guessed,
            letter_q: q_guessed,
            letter_r: r_guessed,
            letter_s: s_guessed,
            letter_t: t_guessed,
            letter_u: u_guessed,
            letter_v: v_guessed,
            letter_w: w_guessed,
            letter_x: x_guessed,
            letter_y: y_guessed,
            letter_z: z_guessed,
        };
        return new_guesses;
    }

    // Manually call each check letter function and count the total number of correct letter gueses
    inline check_all_letters(word: Word, letter: u8) -> u8 {
        let correct_guesses: u8 = 0u8;
        if (check_letter_1(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_2(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_3(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_4(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_5(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_6(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_7(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_8(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_9(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_10(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_11(letter, word)) {
            correct_guesses += 1u8;
        }
        if (check_letter_12(letter, word)) {
            correct_guesses += 1u8;
        }
        return correct_guesses;
    }

    inline check_letter_1(letter: u8, word: Word) -> bool {
        return letter == word.letter_1;
    }

    inline check_letter_2(letter: u8, word: Word) -> bool {
        return letter == word.letter_2;
    }

    inline check_letter_3(letter: u8, word: Word) -> bool {
        return letter == word.letter_3;
    }

    inline check_letter_4(letter: u8, word: Word) -> bool {
        return letter == word.letter_4;
    }

    inline check_letter_5(letter: u8, word: Word) -> bool {
        return letter == word.letter_5;
    }

    inline check_letter_6(letter: u8, word: Word) -> bool {
        return letter == word.letter_6;
    }

    inline check_letter_7(letter: u8, word: Word) -> bool {
        return letter == word.letter_7;
    }

    inline check_letter_8(letter: u8, word: Word) -> bool {
        return letter == word.letter_8;
    }

    inline check_letter_9(letter: u8, word: Word) -> bool {
        return letter == word.letter_9;
    }

    inline check_letter_10(letter: u8, word: Word) -> bool {
        return letter == word.letter_10;
    }

    inline check_letter_11(letter: u8, word: Word) -> bool {
        return letter == word.letter_11;
    }

    inline check_letter_12(letter: u8, word: Word) -> bool {
        return letter == word.letter_12;
    }
}
