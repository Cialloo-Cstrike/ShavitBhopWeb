package misc

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strconv"
)

// MarshalStructToJSONString takes any struct or slice of structs and returns its JSON representation,
// converting all numeric fields to strings.
func MarshalJsonNumberAsStringValue(v interface{}) ([]byte, error) {
	val := reflect.ValueOf(v)

	// Check if the provided value is a struct or a slice
	if val.Kind() != reflect.Struct && val.Kind() != reflect.Slice {
		return []byte{}, fmt.Errorf("expected a struct or slice, got %s", val.Kind())
	}

	var result interface{}

	if val.Kind() == reflect.Slice {
		// Handle slice of structs
		slice := make([]interface{}, val.Len())
		for i := 0; i < val.Len(); i++ {
			item := val.Index(i)
			if item.Kind() != reflect.Struct {
				return []byte{}, fmt.Errorf("expected struct in slice, got %s", item.Kind())
			}
			marshaledItem, err := marshalStruct(item)
			if err != nil {
				return []byte{}, err
			}
			slice[i] = marshaledItem
		}
		result = slice
	} else {
		// Handle single struct
		marshaledItem, err := marshalStruct(val)
		if err != nil {
			return []byte{}, err
		}
		result = marshaledItem
	}

	// Marshal the final result to JSON
	jsonData, err := json.Marshal(result)
	if err != nil {
		return []byte{}, err
	}

	return []byte(jsonData), nil
}

// marshalStruct marshals a single struct and converts numeric fields to strings.
func marshalStruct(val reflect.Value) (map[string]interface{}, error) {
	mappedData := make(map[string]interface{})
	t := val.Type()

	for i := 0; i < val.NumField(); i++ {
		field := val.Field(i)
		fieldType := t.Field(i)

		// Convert numeric types to string
		if field.Kind() == reflect.Int || field.Kind() == reflect.Int8 || field.Kind() == reflect.Int16 ||
			field.Kind() == reflect.Int32 || field.Kind() == reflect.Int64 {
			mappedData[fieldType.Tag.Get("json")] = strconv.FormatInt(field.Int(), 10)
		} else if field.Kind() == reflect.Uint || field.Kind() == reflect.Uint8 || field.Kind() == reflect.Uint16 ||
			field.Kind() == reflect.Uint32 || field.Kind() == reflect.Uint64 {
			mappedData[fieldType.Tag.Get("json")] = strconv.FormatUint(field.Uint(), 10)
		} else {
			// For other types, use the default value
			mappedData[fieldType.Tag.Get("json")] = field.Interface()
		}
	}

	return mappedData, nil
}
