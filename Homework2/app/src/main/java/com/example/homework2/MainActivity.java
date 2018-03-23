package com.example.homework2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.CheckBox;
import android.widget.RadioButton;
import android.widget.Spinner;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.TextView;
import android.view.View;
import android.view.View.OnClickListener;
import android.content.Intent;
import java.util.*;
import android.net.Uri;

public class MainActivity extends AppCompatActivity {

    private Spinner spinner1;
    private Button button;
    private TextView textView;
    private TextView email;
    private TextView subject;
    private String ds;
    private RadioButton AC;
    private CheckBox insertB;
    private CheckBox minB;
    private CheckBox searchB;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        itemSpinner();
        buttonListener();
    }
    public void onClick(View view)
    {
        int position = spinner1.getSelectedItemPosition();
        Intent intent = null;

        switch(position)
        {
            case 0:
                intent = new Intent(Intent.ACTION_VIEW, Uri.parse("Binary Search Tree"));
                break;
            case 1:
                intent = new Intent(Intent.ACTION_VIEW, Uri.parse("Linked List"));
                break;
        }
        if(intent != null)
        {
            startActivity(intent);
        }

    }

    public void itemSpinner()
    {
        spinner1 = findViewById(R.id.spinner);
        ArrayList<String> list = new ArrayList<>();
        list.add("Binary Search Tree");
        list.add("Linked List");
        ArrayAdapter<String> dataAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, list);
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner1.setAdapter(dataAdapter);
    }
    public void buttonListener()
    {
        spinner1 = findViewById(R.id.spinner);
        email = findViewById(R.id.editText4);
        subject = findViewById(R.id.editText6);
        button = findViewById(R.id.emailButton);
        button.setOnClickListener(new OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                textView = findViewById(R.id.textView17);
                ds = spinner1.getSelectedItem().toString();
                AC = findViewById(R.id.radioButton);
                insertB = findViewById(R.id.checkBox2);
                minB = findViewById(R.id.checkBox);
                searchB = findViewById(R.id.checkBox3);
                if(ds.equals("Binary Search Tree"))
                {
                    if(AC.isChecked())
                    {
                        textView.setText("Average Case Time Complexity for " + ds + " Operations");
                        if(insertB.isChecked())
                        {
                            textView = findViewById(R.id.textView21);
                            textView.setText("Insert: O(log n)");
                        }
                        if(minB.isChecked())
                        {
                            textView = findViewById(R.id.textView22);
                            textView.setText("Get Minimum: O(log n)");
                        }
                        if(searchB.isChecked())
                        {
                            textView = findViewById(R.id.textView22);
                            textView.setText("Search: O(log n)");
                        }
                    }
                    else
                    {
                        textView.setText("Worst Case Time Complexity for " + ds + " Operations");
                        if(insertB.isChecked())
                        {
                            textView = findViewById(R.id.textView21);
                            textView.setText("Insert: O(n)");
                        }
                        if(minB.isChecked())
                        {
                            textView = findViewById(R.id.textView22);
                            textView.setText("Get Minimum: O(n)");
                        }
                        if(searchB.isChecked())
                        {
                            textView = findViewById(R.id.textView22);
                            textView.setText("Search: O(n)");
                        }
                    }
                }
                if(ds.equals("Linked List"))
                {
                    if(AC.isChecked())
                    {
                        textView.setText("Average Case Time Complexity for " + spinner1.getSelectedItem().toString() + " Operations");
                        if(insertB.isChecked())
                        {
                            textView = findViewById(R.id.textView21);
                            textView.setText("Insert(at beginning): O(1)");
                        }
                        if(minB.isChecked())
                        {
                            textView = findViewById(R.id.textView22);
                            textView.setText("Get Minimum: O(n)");
                        }
                        if(searchB.isChecked())
                        {
                            textView = findViewById(R.id.textView22);
                            textView.setText("Search: O(n)");
                        }
                    }
                    else
                    {
                        textView.setText("Worst Case Time Complexity for " + spinner1.getSelectedItem().toString() + " Operations");
                        if(insertB.isChecked())
                        {
                            textView = findViewById(R.id.textView21);
                            textView.setText("Insert(at beginning): O(1)");
                        }
                        if(minB.isChecked())
                        {
                            textView = findViewById(R.id.textView22);
                            textView.setText("Get Minimum: O(n)");
                        }
                        if(searchB.isChecked())
                        {
                            textView = findViewById(R.id.textView22);
                            textView.setText("Search: O(n)");
                        }
                    }
                }
                textView = findViewById(R.id.textView18);
                textView.setText(email.getText());
                textView = findViewById(R.id.textView19);
                textView.setText(subject.getText());

            }
        });
    }
}
