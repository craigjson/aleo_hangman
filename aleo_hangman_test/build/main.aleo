program aleo_hangman_test.aleo;

struct GuessedLetters:
    letter_a as boolean;
    letter_b as boolean;
    letter_c as boolean;
    letter_d as boolean;
    letter_e as boolean;
    letter_f as boolean;
    letter_g as boolean;
    letter_h as boolean;
    letter_i as boolean;
    letter_j as boolean;
    letter_k as boolean;
    letter_l as boolean;
    letter_m as boolean;
    letter_n as boolean;
    letter_o as boolean;
    letter_p as boolean;
    letter_q as boolean;
    letter_r as boolean;
    letter_s as boolean;
    letter_t as boolean;
    letter_u as boolean;
    letter_v as boolean;
    letter_w as boolean;
    letter_x as boolean;
    letter_y as boolean;
    letter_z as boolean;

struct GameState:
    guesser as address;
    max_attempts as u8;
    letters_guessed as u8;
    game_status as u8;
    attempts_made as u8;
    game_id as u128;
    player_won as boolean;
    guessed_letters as GuessedLetters;

struct Word:
    length as u8;
    letter_1 as u8;
    letter_2 as u8;
    letter_3 as u8;
    letter_4 as u8;
    letter_5 as u8;
    letter_6 as u8;
    letter_7 as u8;
    letter_8 as u8;
    letter_9 as u8;
    letter_10 as u8;
    letter_11 as u8;
    letter_12 as u8;

record HangmanGame:
    owner as address.private;
    game_state as GameState.private;
    word as Word.private;


mapping games:
	key left as u128.public;
	value right as GameState.public;

function start_game:
    input r0 as address.public;
    input r1 as Word.private;
    input r2 as u8.public;
    cast false false false false false false false false false false false false false false false false false false false false false false false false false false into r3 as GuessedLetters;
    cast r0 r2 0u8 1u8 0u8 0u128 false r3 into r4 as GameState;
    cast self.caller r4 r1 into r5 as HangmanGame.record;
    output r5 as HangmanGame.record;

    finalize 0u128 r4;

finalize start_game:
    input r0 as u128.public;
    input r1 as GameState.public;
    set r1 into games[r0];






























function make_guess:
    input r0 as u8.public;
    input r1 as HangmanGame.record;
    add r1.game_state.attempts_made 1u8 into r2;
    is.eq r0 97u8 into r3;
    ternary r3 true false into r4;
    is.eq r0 98u8 into r5;
    ternary r5 true false into r6;
    is.eq r0 99u8 into r7;
    ternary r7 true false into r8;
    is.eq r0 100u8 into r9;
    ternary r9 true false into r10;
    is.eq r0 101u8 into r11;
    ternary r11 true false into r12;
    is.eq r0 102u8 into r13;
    ternary r13 true false into r14;
    is.eq r0 103u8 into r15;
    ternary r15 true false into r16;
    is.eq r0 104u8 into r17;
    ternary r17 true false into r18;
    is.eq r0 105u8 into r19;
    ternary r19 true false into r20;
    is.eq r0 106u8 into r21;
    ternary r21 true false into r22;
    is.eq r0 107u8 into r23;
    ternary r23 true false into r24;
    is.eq r0 108u8 into r25;
    ternary r25 true false into r26;
    is.eq r0 109u8 into r27;
    ternary r27 true false into r28;
    is.eq r0 110u8 into r29;
    ternary r29 true false into r30;
    is.eq r0 111u8 into r31;
    ternary r31 true false into r32;
    is.eq r0 112u8 into r33;
    ternary r33 true false into r34;
    is.eq r0 113u8 into r35;
    ternary r35 true false into r36;
    is.eq r0 114u8 into r37;
    ternary r37 true false into r38;
    is.eq r0 115u8 into r39;
    ternary r39 true false into r40;
    is.eq r0 116u8 into r41;
    ternary r41 true false into r42;
    is.eq r0 117u8 into r43;
    ternary r43 true false into r44;
    is.eq r0 118u8 into r45;
    ternary r45 true false into r46;
    is.eq r0 119u8 into r47;
    ternary r47 true false into r48;
    is.eq r0 120u8 into r49;
    ternary r49 true false into r50;
    is.eq r0 121u8 into r51;
    ternary r51 true false into r52;
    is.eq r0 122u8 into r53;
    ternary r53 true false into r54;
    cast r4 r6 r8 r10 r12 r14 r16 r18 r20 r22 r24 r26 r28 r30 r32 r34 r36 r38 r40 r42 r44 r46 r48 r50 r52 r54 into r55 as GuessedLetters;
    gt r2 r1.game_state.max_attempts into r56;
    ternary r56 2u8 1u8 into r57;
    is.eq r0 r1.word.letter_1 into r58;
    add 0u8 1u8 into r59;
    ternary r58 r59 0u8 into r60;
    is.eq r0 r1.word.letter_2 into r61;
    add r60 1u8 into r62;
    ternary r61 r62 r60 into r63;
    is.eq r0 r1.word.letter_3 into r64;
    add r63 1u8 into r65;
    ternary r64 r65 r63 into r66;
    is.eq r0 r1.word.letter_4 into r67;
    add r66 1u8 into r68;
    ternary r67 r68 r66 into r69;
    is.eq r0 r1.word.letter_5 into r70;
    add r69 1u8 into r71;
    ternary r70 r71 r69 into r72;
    is.eq r0 r1.word.letter_6 into r73;
    add r72 1u8 into r74;
    ternary r73 r74 r72 into r75;
    is.eq r0 r1.word.letter_7 into r76;
    add r75 1u8 into r77;
    ternary r76 r77 r75 into r78;
    is.eq r0 r1.word.letter_8 into r79;
    add r78 1u8 into r80;
    ternary r79 r80 r78 into r81;
    is.eq r0 r1.word.letter_9 into r82;
    add r81 1u8 into r83;
    ternary r82 r83 r81 into r84;
    is.eq r0 r1.word.letter_10 into r85;
    add r84 1u8 into r86;
    ternary r85 r86 r84 into r87;
    is.eq r0 r1.word.letter_11 into r88;
    add r87 1u8 into r89;
    ternary r88 r89 r87 into r90;
    is.eq r0 r1.word.letter_12 into r91;
    add r90 1u8 into r92;
    ternary r91 r92 r90 into r93;
    is.eq r93 r1.word.length into r94;
    ternary r94 2u8 r57 into r95;
    ternary r94 true false into r96;
    add r1.game_state.attempts_made 1u8 into r97;
    cast r1.game_state.guesser r1.game_state.max_attempts r1.game_state.letters_guessed r95 r97 r1.game_state.game_id r96 r1.game_state.guessed_letters into r98 as GameState;
    cast self.caller r98 r1.word into r99 as HangmanGame.record;
    output r99 as HangmanGame.record;

    finalize r1.game_state.game_id r1.game_state;

finalize make_guess:
    input r0 as u128.public;
    input r1 as GameState.public;
    set r1 into games[r0];


