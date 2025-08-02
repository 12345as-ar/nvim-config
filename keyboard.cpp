#include "keyboard.h"
#include <cctype>
#include <chrono>
#include <ctime>
#include <iostream>
#include <raylib.h>


void Keyboard::sendKeys(Text &t) {
  // key repeat stuff
  if (IsKeyReleased(repeatKey)) {
    wait = std::chrono::high_resolution_clock::now();
    repeatKey = 0;
  } else if (std::chrono::duration_cast<std::chrono::milliseconds>(
                 std::chrono::high_resolution_clock::now() - wait)
                 .count() > 300) {
    if (repeats == 2) {
      sendCommand(repeatKey + 1000 * IsKeyDown(KEY_LEFT_SHIFT) +
                      10000 * IsKeyDown(KEY_RIGHT_ALT) +
                      100000 * IsKeyDown(KEY_LEFT_CONTROL),
                  t);
      repeats = 0;
    } else {
      ++repeats;
    }
  }
  // regular inputs
  unsigned key = GetKeyPressed();
  while (key > 0) {
    // std::cout << key << (char)key << " " << IsKeyDown(KEY_LEFT_SHIFT) <<
    // std::endl;
    sendCommand(key + 1000 * IsKeyDown(KEY_LEFT_SHIFT) +
                    10000 * IsKeyDown(KEY_RIGHT_ALT) +
                    100000 * IsKeyDown(KEY_LEFT_CONTROL),
                t);
    wait = std::chrono::high_resolution_clock::now();
    repeatKey = key;
    key = GetKeyPressed();
  }
  // scrolling
  t.scroll(GetMouseWheelMove());
  if (IsMouseButtonPressed(MOUSE_BUTTON_LEFT)) {
    Vector2 pos = GetMousePosition();
    t.leftMouse(pos.x, pos.y);
  }
}

void Keyboard::sendCommand(unsigned key, Text &t) {
  if (key) {
    switch (key) {
    case KEY_BACKSPACE:
      t.del();
      break;
    case KEY_RIGHT:
      t.setCol(t.getCol() + 1);
      break;
    case KEY_LEFT:
      t.setCol(t.getCol() - 1);
      break;
    case KEY_DOWN:
      t.setRow(t.getRow() + 1);
      break;
    case KEY_UP:
      t.setRow(t.getRow() - 1);
      break;
    case KEY_ENTER:
      t.newLine();
      break;
    case KEY_SPACE:
      t.write(' ');
      undo_list.push_back(t.save());
      break;
    case KEY_Z + 100000:
      if (undo_list.size()) {
        redo_list.push_back(t.save());
        t.restore(&undo_list[undo_list.size() - 1]);
        undo_list.erase(undo_list.end() - 1);
        std::cout << "undid" << undo_list.size() << std::endl;
      } else {
        std::cout << "nothing to undo" << std::endl;
      }
      break;
    case KEY_Y + 100000:
      if (redo_list.size()) {
        undo_list.push_back(t.save());
        t.restore(&redo_list[redo_list.size() - 1]);
        redo_list.erase(redo_list.end() - 1);
        }
      break;
    default:
      if (char_map.count(key)) {
        t.write(char_map.at(key));
      }
      break;
    }
  }
}
